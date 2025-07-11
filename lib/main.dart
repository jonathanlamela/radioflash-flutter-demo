import 'dart:io';
import 'firebase_options.dart';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radioflash/provider.dart';
import 'package:radioflash/screens/impostazioni.dart';
import 'package:radioflash/screens/full_page_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RadioMeta.dart';
import 'ThemeConfig.dart';
import 'package:flutter/material.dart';
import 'screens/app_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

String? linkToOpen;

late AudioHandler audioHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'radioflash_news', // id
    'Notifiche RadioFlash', // title
    description: 'Notifiche per le notizie RadioFlash', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel!);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_logo_vettoriale');

  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null);

  flutterLocalNotificationsPlugin!.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) =>
        {launchUrl(Uri.parse(linkToOpen!))},
  );

  var initialMessage = await messaging.getInitialMessage();

  if (initialMessage != null) {
    if (initialMessage.data.containsKey("url")) {
      launchUrl(initialMessage.data["url"]);
    }
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification!;

    if (message.data.containsKey("url")) {
      linkToOpen = message.data["url"];
    }

    AndroidNotification? android = message.notification?.android;

    if (android != null) {
      flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              channelDescription: channel!.description,
              color: Colors.red[900],
            ),
          ));
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.data.containsKey("url")) {
      launchUrl(message.data["url"]);
    }
  });

  audioHandler = await AudioService.init(
      builder: () => IsolatedAudioHandler(BackgroundMusicTask(),
          portName: 'my_audio_handler'),
      config: AudioServiceConfig(
        androidStopForegroundOnPause: true,
        androidNotificationChannelId:
            'com.realeventsrl.radioflash.channel.audio',
        androidNotificationChannelName: 'Music playback',
      ));

  initializeDateFormatting('it_IT', null).then(
    (_) => runApp(ProviderScope(child: MyApp())),
  );
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(playerStatusProvider.notifier).syncNow();
    ref.read(playerStatusProvider.notifier).startToFetch();
    ref.read(onAirProvider.notifier).syncNow();
    ref.read(onAirProvider.notifier).startToFetch();

    return MaterialApp(
      title: 'RadioFlash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: context.themePrimary(),
          fontFamily: context.mainFontFamily()),
      onGenerateRoute: (settings) {
        if (settings.name == 'home') {
          return MaterialPageRoute(
            builder: (context) {
              return AppContainer();
            },
          );
        }

        if (settings.name == 'fullpageplayer') {
          return MaterialPageRoute(
            builder: (context) {
              return FullPagePlayer();
            },
          );
        }

        if (settings.name == 'impostazioni') {
          return MaterialPageRoute(
            builder: (context) {
              return ImpostazioniScreen();
            },
          );
        }

        return MaterialPageRoute(
          builder: (context) {
            return AppContainer();
          },
        );
      },
      initialRoute: 'home',
    );
  }
}

class BackgroundMusicTask extends BaseAudioHandler {
  var audioPlayer = AudioPlayer(
    userAgent: 'radioflash/1.0 (Linux;Android 11) https://www.radioflash.fm',
  );

  BackgroundMusicTask() {
    initPlayer();
  }

  void initPlayer() async {
    audioPlayer.setUrl(playlist[0]["linkFlusso"]!);

    mediaItem.add(MediaItem(
        id: '',
        album: '',
        title: "Radio Flash",
        artist: "Ascolta la Radio",
        artUri: Uri.parse(defaultCoverUrl)));

    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.ready,
        controls: [MediaControl.play],
      ),
    );
  }

  @override
  Future<void> onTaskRemoved() async {
    stop();
    return super.onTaskRemoved();
  }

  @override
  Future<void> stop() async {
    audioPlayer.dispose();
    await super.stop();
    exit(0);
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    if (name == "notifyData") {
      var currentData = extras!;
      mediaItem.add(MediaItem(
        id: '',
        album: '',
        title: currentData["titolo"],
        artist: currentData["artist"],
        artUri: Uri.parse(currentData["coverLink"]),
      ));
    }

    if (name == "changeUrl") {
      var lastState = audioPlayer.playerState.playing;

      if (lastState) {
        pause();
      }

      audioPlayer.setUrl(extras!["url"]);

      if (lastState) {
        play();
      }
    }
  }

  @override
  Future<void> play() async {
    customEvent.add('playClick');
    playbackState.add(
      playbackState.value.copyWith(
        playing: true,
        processingState: AudioProcessingState.ready,
        controls: [MediaControl.pause],
      ),
    );

    audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    customEvent.add('pauseClick');
    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.ready,
        controls: [MediaControl.play],
      ),
    );
    audioPlayer.pause();
  }
}

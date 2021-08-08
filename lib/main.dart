import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/bloc/classifica_bloc.dart';
import 'package:radioflash/bloc/latestsong_bloc.dart';
import 'package:radioflash/bloc/navigation_bloc.dart';
import 'package:radioflash/bloc/onairprogram_bloc.dart';
import 'package:radioflash/bloc/player_bloc.dart';
import 'package:radioflash/cubit/annoclassifica_cubit.dart';
import 'package:radioflash/screens/FullPagePlayer/FullPagePlayer.dart';
import 'package:radioflash/screens/Impostazioni/Impostazioni.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RadioMeta.dart';
import 'ThemeConfig.dart';
import 'package:flutter/material.dart';
import 'screens/AppContainer.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'radioflash_news', // id
    'Notifiche RadioFlash', // title
    'Notifiche per le notizie RadioFlash', // description
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

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
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
    onSelectNotification: (payload) async {
      launch(linkToOpen!);
    },
  );

  var initialMessage = await messaging.getInitialMessage();

  if (initialMessage != null) {
    if (initialMessage.data.containsKey("url")) {
      launch(initialMessage.data["url"]);
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
              channel!.description,
              color: Colors.red[900],
            ),
          ));
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.data.containsKey("url")) {
      launch(message.data["url"]);
    }
  });

  var annoCubit = AnnoclassificaCubit();

  initializeDateFormatting('it_IT', null).then(
    (_) => runApp(MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (BuildContext context) => NavigationBloc(),
        ),
        BlocProvider<LatestsongBloc>(
          create: (BuildContext context) => LatestsongBloc(),
        ),
        BlocProvider<OnairprogramBloc>(
          create: (BuildContext context) => OnairprogramBloc(),
        ),
        BlocProvider<PlayerBloc>(
          create: (BuildContext context) => PlayerBloc(),
        ),
        BlocProvider<ClassificaBloc>(
          create: (context) => ClassificaBloc(annoCubit),
        ),
        BlocProvider<AnnoclassificaCubit>(create: (context) => annoCubit),
      ],
      child: MyApp(),
    )),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<OnairprogramBloc>().add(OnairprogramStartToFetchEvent());
    context.read<LatestsongBloc>().add(LatestsongStartToFetchEvent());
    context.read<PlayerBloc>().add(PlayerStartToFetchEvent());

    context.read<LatestsongBloc>().add(LatestsongSyncNowEvent());
    context.read<OnairprogramBloc>().add(OnairprogramSyncNowEvent());
    context.read<PlayerBloc>().add(PlayerSyncNowEvent());

    AudioService.start(
        backgroundTaskEntrypoint: backgroundTaskEntrypoint,
        androidStopForegroundOnPause: true);

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
              return AudioServiceWidget(
                child: AppContainer(),
              );
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
            return AudioServiceWidget(
              child: AppContainer(),
            );
          },
        );
      },
      initialRoute: 'home',
    );
  }
}

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => BackgroundMusicTask());
}

class BackgroundMusicTask extends BackgroundAudioTask {
  var audioPlayer = AudioPlayer(
    userAgent: 'radioflash/1.0 (Linux;Android 11) https://www.radioflash.fm',
  );

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    audioPlayer.setUrl(playlist[0]["linkFlusso"]!);
    await AudioServiceBackground.setMediaItem(
      MediaItem(
          id: '',
          album: '',
          title: "Radio Flash",
          artist: "Ascolta la Radio",
          artUri: Uri.parse(defaultCoverUrl)),
    );

    await AudioServiceBackground.setState(
      playing: false,
      processingState: AudioProcessingState.ready,
      controls: [MediaControl.play],
    );
  }

  @override
  Future<void> onTaskRemoved() async {
    onStop();
    return super.onTaskRemoved();
  }

  @override
  Future<void> onStop() async {
    audioPlayer.dispose();
    await AudioService.stop();
    await super.onStop();
    exit(0);
  }

  @override
  Future<dynamic> onCustomAction(String name, dynamic arguments) async {
    if (name == "notifyData") {
      var currentData = arguments;

      await AudioServiceBackground.setMediaItem(
        MediaItem(
          id: '',
          album: '',
          title: currentData["titolo"],
          artist: currentData["artist"],
          artUri: Uri.parse(currentData["coverLink"]),
        ),
      );
    }

    if (name == "changeUrl") {
      var lastState = audioPlayer.playerState.playing;

      if (lastState) {
        AudioService.pause();
      }

      audioPlayer.setUrl(arguments);

      if (lastState) {
        AudioService.play();
      }
    }
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.sendCustomEvent('playClick');
    await AudioServiceBackground.setState(
      playing: true,
      processingState: AudioProcessingState.ready,
      controls: [MediaControl.pause],
    );

    audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.sendCustomEvent('pauseClick');
    await AudioServiceBackground.setState(
      playing: false,
      processingState: AudioProcessingState.ready,
      controls: [MediaControl.play],
    );
    audioPlayer.pause();
  }
}

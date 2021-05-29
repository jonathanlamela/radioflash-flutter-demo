import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/services/HitsProvider.dart';
import 'package:radioflash/services/UltimeUsciteProvider.dart';
import 'RadioMeta.dart';
import 'ThemeConfig.dart';
import 'services/NavigationProvider.dart';
import 'services/OnAirProgramProvider.dart';
import 'services/PlayerProvider.dart';
import 'package:flutter/material.dart';
import 'screens/AppContainer.dart';
import 'services/OnAirLatestSongProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerProvider>(
          create: (context) => PlayerProvider(),
        ),
        ChangeNotifierProvider<OnAirProgramProvider>(
            create: (context) => OnAirProgramProvider()),
        ChangeNotifierProvider<NavigationProvider>(
            create: (context) => NavigationProvider()),
        ChangeNotifierProvider<OnAirLatestSongProvider>(
            create: (context) => OnAirLatestSongProvider()),
        ChangeNotifierProvider<UltimeUsciteProvider>(
            create: (context) => UltimeUsciteProvider()),
        ChangeNotifierProvider<HitsProvider>(
            create: (context) => HitsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<OnAirProgramProvider>(context, listen: false).startSync();
    Provider.of<OnAirLatestSongProvider>(context, listen: false).startSync();
    Provider.of<PlayerProvider>(context, listen: false).startSync();

    Provider.of<OnAirLatestSongProvider>(context, listen: false).syncNow();
    Provider.of<OnAirProgramProvider>(context, listen: false).syncNow();
    Provider.of<UltimeUsciteProvider>(context, listen: false).syncNow();
    Provider.of<HitsProvider>(context, listen: false).syncNow(hitsLink);

    AudioService.start(
        backgroundTaskEntrypoint: backgroundTaskEntrypoint,
        androidStopForegroundOnPause: true);

    return MaterialApp(
      title: 'RadioFlash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: context.themePrimary()),
      home: AudioServiceWidget(
        child: AppContainer(),
      ),
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

import 'dart:async';
import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'package:flutter/material.dart';

import '../RadioMeta.dart';
import 'package:http/http.dart' as http;

import '../models/TrackItem.dart';

Future fetchData(dynamic currentPlaylist) async {
  var httpClient = http.Client();

  var response =
      await httpClient.get(Uri.parse(currentPlaylist["linkUltimiSuonati"]));

  return jsonDecode(response.body)["result"];
}

class PlayerProvider extends ChangeNotifier {
  var audioPlayer = AudioPlayer(
    userAgent: 'radioflash/1.0 (Linux;Android 11) https://www.radioflash.fm',
  );
  var currentPlaylist = playlist[0];
  var currentPlaylistIndex = 0;
  List<TrackItem> currentList = [];
  var syncIsBusy = false;
  var syncLsIsBusy = false;
  var isPlaying = false;
  var channelMobile = MethodChannel('com.realeventsrl.radioflash');

  PlayerProvider() {
    audioPlayer.setUrl(currentPlaylist["linkFlusso"]!);
    AudioService.connect();
    AudioService.playbackStateStream.listen((event) {
      if (event.playing != isPlaying) {
        isPlaying = event.playing;
        notifyListeners();
      }
    });
    AudioService.customEventStream.listen((event) {
      if (event == 'syncNow') {
        syncNow();
      }

      if (event == 'forceSync') {
        syncNow();
      }
    });
  }

  startSync() {
    syncNow();
    Timer.periodic(Duration(seconds: 5), (timer) async {
      await syncNow();
    });
  }

  syncNow() async {
    var response = await fetchData(currentPlaylist);
    List<TrackItem> responseMap =
        response.map<TrackItem>((e) => TrackItem.fromJson(e)).toList();

    if (currentList.isNotEmpty) {
      if (responseMap[0].title != currentList[0].title) {
        currentList = responseMap;
        AudioService.customAction('notifyData', {
          "titolo": currentList.first.title,
          "artist": currentList.first.artist,
          "coverLink": currentList.first.artworkSmallUrl
        });
        notifyListeners();
      }
    } else {
      currentList = responseMap;
      AudioService.customAction('notifyData', {
        "titolo": currentList.first.title,
        "artist": currentList.first.artist,
        "coverLink": currentList.first.artworkSmallUrl
      });
      notifyListeners();
    }
  }

  void play() {
    isPlaying = true;
    AudioService.play();
    notifyListeners();
  }

  void stop() {
    isPlaying = false;
    AudioService.pause();
    notifyListeners();
  }

  changePlaylist(int index) {
    currentPlaylist = playlist[index];
    currentPlaylistIndex = index;
    currentList = [];
    notifyListeners();

    AudioService.customAction('changeUrl', currentPlaylist["linkFlusso"]);

    syncNow();
  }
}

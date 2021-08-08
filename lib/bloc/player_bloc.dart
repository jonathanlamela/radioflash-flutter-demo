import 'dart:async';
import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:just_audio/just_audio.dart';

import '../RadioMeta.dart';
import 'package:http/http.dart' as http;

import '../models/TrackItem.dart';

part 'player_event.dart';
part 'player_state.dart';

Future fetchData(dynamic currentPlaylist) async {
  var httpClient = http.Client();

  var response =
      await httpClient.get(Uri.parse(currentPlaylist["linkUltimiSuonati"]));

  return jsonDecode(response.body)["result"];
}

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    audioPlayer.setUrl(currentPlaylist["linkFlusso"]!);
    AudioService.connect();
    AudioService.playbackStateStream.listen((event) {
      if (event.playing != isPlaying) {
        isPlaying = event.playing;
        add(PlayerPlayingChangeEvent(isPlaying: isPlaying));
      }
    });
    AudioService.customEventStream.listen((event) {
      if (event == 'syncNow') {
        add(PlayerSyncNowEvent());
      }

      if (event == 'forceSync') {
        add(PlayerSyncNowEvent());
      }
    });
  }

  var isPlaying = false;
  var audioPlayer = AudioPlayer(
    userAgent: 'radioflash/1.0 (Linux;Android 11) https://www.radioflash.fm',
  );
  var currentPlaylist = playlist[0];
  var currentPlaylistIndex = 0;
  List<TrackItem> currentList = [];
  var syncIsBusy = false;
  var syncLsIsBusy = false;

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    //START TO SYNC
    if (event is PlayerStartToFetchEvent) {
      Timer.periodic(Duration(seconds: 5), (timer) async {
        add(PlayerSyncNowEvent());
      });
    }

    if (event is PlayerPlayingChangeEvent) {
      this.isPlaying = event.isPlaying;
      if (isPlaying) {
        AudioService.play();
      } else {
        AudioService.pause();
      }
      yield PlayerPlayingChangeState(
          isPlaying: isPlaying,
          currentList: currentList,
          currentPlaylistIndex: currentPlaylistIndex);
    }

    if (event is PlayerSyncNowEvent) {
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
          add(PlayerDataChangeEvent(currentList));
        }
      } else {
        currentList = responseMap;
        AudioService.customAction('notifyData', {
          "titolo": currentList.first.title,
          "artist": currentList.first.artist,
          "coverLink": currentList.first.artworkSmallUrl
        });
        add(PlayerDataChangeEvent(currentList));
      }
    }

    if (event is PlayerDataChangeEvent) {
      yield PlayerDataChangeState(
          isPlaying: isPlaying,
          currentList: currentList,
          currentPlaylistIndex: currentPlaylistIndex);
    }

    if (event is PlayerChangePlaylistEvent) {
      currentPlaylist = playlist[event.index];
      currentPlaylistIndex = event.index;
      currentList = [];

      yield PlayerPlaylistChangeState(
          isPlaying: isPlaying,
          currentList: currentList,
          currentPlaylistIndex: currentPlaylistIndex);

      await AudioService.customAction(
          'changeUrl', currentPlaylist["linkFlusso"]);

      add(PlayerSyncNowEvent());
    }
  }
}

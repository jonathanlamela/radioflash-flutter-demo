import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/main.dart';
import 'package:radioflash/models/PlayerStatus.dart';
import 'package:radioflash/models/TrackItem.dart';
import 'package:http/http.dart' as http;

class PlayerProvider extends StateNotifier<PlayerStatus> {
  final Ref ref;
  var audioPlayer = AudioPlayer(
    userAgent: 'radioflash/1.0 (Linux;Android 11) https://www.radioflash.fm',
  );

  PlayerProvider(this.ref)
      : super(PlayerStatus(
            isPlaying: false,
            currentList: [],
            currentPlaylist: playlist[0],
            currentPlaylistIndex: 0)) {
    audioPlayer.setUrl(this.state.currentPlaylist["linkFlusso"]!);

    //connette queste instanza al servizio audio
    connectToAudioService();

    this.syncNow();
    this.startToFetch();
  }

  //cambia lo stato a livello ui
  changePlaying(bool value) {
    this.state = this.state.copyWith(isPlaying: value);
  }

//cambia lo stato del player e lo sincronizza con il componente audio player
  setIsPlaying(bool value) {
    changePlaying(value);
    if (this.state.isPlaying) {
      audioHandler.play();
    } else {
      audioHandler.pause();
    }
  }

//sincronizza i dati sulla traccia in corso
  syncNow() async {
    var response = await fetchData(this.state.currentPlaylist);
    List<TrackItem> responseMap =
        response.map<TrackItem>((e) => TrackItem.fromJson(e)).toList();

    if (this.state.currentList.isNotEmpty) {
      if (responseMap[0].title != this.state.currentList[0].title) {
        this.state = this.state.copyWith(currentList: responseMap);

        audioHandler.customAction('notifyData', {
          "titolo": this.state.currentList.first.title,
          "artist": this.state.currentList.first.artist,
          "coverLink": this.state.currentList.first.artworkSmallUrl
        });
      }
    } else {
      this.state = this.state.copyWith(currentList: responseMap);
      audioHandler.customAction('notifyData', {
        "titolo": this.state.currentList.first.title,
        "artist": this.state.currentList.first.artist,
        "coverLink": this.state.currentList.first.artworkSmallUrl
      });
    }
  }

  //cambia la playlist in corso
  changePlaylist(int index) async {
    this.state = this.state.copyWith(
        currentPlaylist: playlist[index],
        currentPlaylistIndex: index,
        currentList: []);

    await audioHandler.customAction(
        'changeUrl', {"url": this.state.currentPlaylist["linkFlusso"]});

    this.syncNow();
  }

  //Inizia il timer che ogni 20 secondi cambia la traccia in corso
  startToFetch() {
    Timer.periodic(Duration(seconds: 20), (timer) async {
      this.syncNow();
    });
  }

  void connectToAudioService() async {
    audioHandler.playbackState.listen((event) {
      if (event.playing != this.state.isPlaying) {
        this.state = this.state.copyWith(isPlaying: event.playing);
      }
    });

    audioHandler.customEvent.listen((event) {
      if (event == 'syncNow') {
        this.syncNow();
      }

      if (event == 'forceSync') {
        this.syncNow();
      }
    });
  }

  Future fetchData(dynamic currentPlaylist) async {
    var httpClient = http.Client();

    var response =
        await httpClient.get(Uri.parse(currentPlaylist["linkUltimiSuonati"]));

    return jsonDecode(response.body)["result"];
  }
}

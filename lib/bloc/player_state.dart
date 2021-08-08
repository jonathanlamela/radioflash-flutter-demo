part of 'player_bloc.dart';

@immutable
abstract class PlayerState {
  int currentPlaylistIndex = 0;
  bool isPlaying = false;
  List<TrackItem> currentList = [];
}

class PlayerInitial extends PlayerState {}

class PlayerDataChangeState extends PlayerState {
  int currentPlaylistIndex = 0;
  bool isPlaying;
  List<TrackItem> currentList = [];
  PlayerDataChangeState(
      {required this.isPlaying,
      required this.currentList,
      required this.currentPlaylistIndex});
}

class PlayerPlaylistChangeState extends PlayerState {
  int currentPlaylistIndex = 0;
  bool isPlaying;
  List<TrackItem> currentList = [];
  PlayerPlaylistChangeState(
      {required this.isPlaying,
      required this.currentList,
      required this.currentPlaylistIndex});
}

class PlayerPlayingChangeState extends PlayerState {
  int currentPlaylistIndex = 0;
  bool isPlaying;
  List<TrackItem> currentList = [];
  PlayerPlayingChangeState(
      {required this.isPlaying,
      required this.currentList,
      required this.currentPlaylistIndex});
}

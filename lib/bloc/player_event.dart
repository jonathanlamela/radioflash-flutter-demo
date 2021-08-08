part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent {}

class PlayerStartToFetchEvent extends PlayerEvent {}

class PlayerPlayingChangeEvent extends PlayerEvent {
  bool isPlaying = false;
  PlayerPlayingChangeEvent({this.isPlaying = false});
}

class PlayerSyncNowEvent extends PlayerEvent {}

class PlayerDataChangeEvent extends PlayerEvent {
  List<TrackItem> currentList = [];
  PlayerDataChangeEvent(this.currentList);
}

class PlayerChangePlaylistEvent extends PlayerEvent {
  int index;
  PlayerChangePlaylistEvent(this.index);
}

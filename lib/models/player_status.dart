import 'package:flutter/material.dart';
import 'package:radioflash/models/tracking_item.dart';

@immutable
class PlayerStatus {
  final bool isPlaying;
  final currentPlaylist;
  final currentPlaylistIndex;
  final List<TrackItem> currentList;

  const PlayerStatus(
      {required this.isPlaying,
      required this.currentPlaylist,
      required this.currentList,
      required this.currentPlaylistIndex});

  PlayerStatus copyWith(
      {bool? isPlaying,
      dynamic currentPlaylist,
      List<TrackItem>? currentList,
      int? currentPlaylistIndex}) {
    return PlayerStatus(
        isPlaying: isPlaying ?? this.isPlaying,
        currentList: currentList ?? this.currentList,
        currentPlaylist: currentPlaylist ?? this.currentPlaylist,
        currentPlaylistIndex:
            currentPlaylistIndex ?? this.currentPlaylistIndex);
  }
}

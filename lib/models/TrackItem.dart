import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

import '../RadioMeta.dart';

class TrackItem {
  String title = playlist[0]["etichettaBreve"]!;
  String artist = "";
  String album = "";
  Image? cover;
  List<dynamic> artistImageCoverList = [];
  bool isSong = true;
  String? artworkSmallUrl;
  DateTime? detectedOn;
  int? quantiMinutiFa;

  TrackItem();

  factory TrackItem.fromJson(Map<String, dynamic> json) {
    var item = TrackItem();

    if (json["title"] != "") {
      item.title = json["title"];
    } else {
      item.title = json["metadata"] ?? playlist[0]["etichettaBreve"];
    }

    item.title = item.title.trim();

    item.album = json["album"] ?? "";
    item.album = item.album.trim();
    item.isSong =
        json["artworkSmall"] != null || json["artistImageList"]?[0] != null;

    String? artworkSmall = json["artworkSmall"];
    String? artistImage = json["artistImageList"]?[0] ?? defaultCoverUrl;

    item.cover = artworkSmall != null
        ? Image.network(artworkSmall)
        : Image.network(artistImage!);

    item.artworkSmallUrl = artworkSmall != null ? artworkSmall : artistImage;

    item.artist = json["artist"] ?? '';
    item.artist = item.artist.trim();
    item.detectedOn = DateTime.parse(json["detectedOn"] ?? DateTime.now());

    item.quantiMinutiFa = DateTime.now().difference(item.detectedOn!).inMinutes;

    return item;
  }
}

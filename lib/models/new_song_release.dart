import 'package:flutter/material.dart';

class NewSongRelease {
  String titolo = "";
  String artista = "";
  Image? cover;
  DateTime? radioDate;

  NewSongRelease();

  factory NewSongRelease.fromJson(Map<String, dynamic> json) {
    var item = NewSongRelease();

    item.titolo = json["title"] ?? "";
    item.artista = json["artist"] ?? "";
    item.cover = Image.network(json["artworkSmall"]);
    item.radioDate = DateTime.parse(json["radioDate"]);

    return item;
  }
}

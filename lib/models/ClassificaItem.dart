import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/models/AutoreItem.dart';
import 'dart:core';

class ClassificaItem {
  String? movement;
  String? posizionePrecedente;
  String? presenze;
  Image? cover;
  String? album;
  List<AutoreItem> autori = [];
  String? titolo;

  ClassificaItem();

  factory ClassificaItem.fromJSON(Map<String, dynamic> json) {
    var item = ClassificaItem();

    item.movement = json["movement"] ?? '=';
    item.posizionePrecedente = json["posizionePrecedente"] ?? "";
    item.presenze = json["presenze"] ?? '';
    item.cover = Image.network(json["cover"] ?? defaultCoverUrl);
    item.album = json["album"] ?? '';
    item.autori = (json["autori"] as List)
        .cast<Map<String, dynamic>>()
        .map<AutoreItem>((e) => AutoreItem.fromJSON(e))
        .toList();

    item.titolo = json["titolo"] ?? '';
    return item;
  }
}

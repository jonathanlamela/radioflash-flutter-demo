import 'package:flutter/material.dart';

class ProgramItem {
  String titolo = "";
  Image? copertina;
  DateTime? orarioInizio;
  DateTime? orarioFine;
  String speaker = "";

  ProgramItem();

  factory ProgramItem.fromJson(Map<String, dynamic> json) {
    var item = ProgramItem();

    item.titolo = json["titolo"] ?? "";
    item.orarioInizio = DateTime.parse("1970-01-01 ${json["orarioInizio"]}");
    item.orarioFine = DateTime.parse("1970-01-01 ${json["orarioFine"]}");
    item.speaker = json["speaker"] ?? "";

    item.copertina = Image.network(json["cover"]);

    return item;
  }
}

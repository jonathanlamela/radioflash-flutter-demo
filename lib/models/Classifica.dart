import 'package:radioflash/models/classifica_item.dart';

class Classifica {
  String? titolo;
  List<ClassificaItem> items = [];
  Classifica();

  factory Classifica.fromJson(Map<String, dynamic> json) {
    var item = Classifica();

    item.titolo = json["titolo"];
    item.items = (json["classifica"] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((e) => ClassificaItem.fromJSON(e))
        .toList();

    return item;
  }
}

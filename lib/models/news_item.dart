import 'package:flutter/material.dart';

import 'package:radioflash/RadioMeta.dart';

class NewsItem {
  String? link;
  String? titolo;
  String? estratto;
  DateTime? data;
  Image? cover;

  NewsItem();
  factory NewsItem.fromJson(json) {
    var item = NewsItem();
    item.link = json["link"] ?? "";
    item.data = DateTime.parse(json["date"] ?? DateTime.now());
    item.titolo = json["title"]?["rendered"] ?? "";
    item.estratto = json["excerpt"]?["rendered"] ?? "";
    item.cover =
        Image.network((json["jetpack_featured_media_url"] ?? defaultCoverUrl));

    return item;
  }
}

import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:radioflash/models/TrackItem.dart';

import '../RadioMeta.dart';
import 'package:http/http.dart' as http;

Future fetchData(dynamic currentPlaylist) async {
  var httpClient = http.Client();

  var response =
      await httpClient.get(Uri.parse(currentPlaylist["linkUltimiSuonati"]));

  return jsonDecode(response.body)["result"].cast<Map<String, dynamic>>() ?? [];
}

class OnAirLatestSongProvider extends ChangeNotifier {
  List<TrackItem> currentList = [];

  startSync() {
    Timer.periodic(Duration(seconds: 40), (timer) async {
      await syncNow();
    });
  }

  syncNow() async {
    var response = await fetchData(playlist[0]);
    List<TrackItem> responseMap =
        response.map<TrackItem>((e) => TrackItem.fromJson(e)).toList();

    if (currentList.isNotEmpty) {
      if (responseMap[0].title != currentList[0].title) {
        currentList = responseMap;
        notifyListeners();
      }
    } else {
      currentList = responseMap;
      notifyListeners();
    }
  }
}

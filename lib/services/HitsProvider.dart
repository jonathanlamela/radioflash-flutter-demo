import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radioflash/models/TrackItem.dart';

Future fetchData(dynamic link) async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(link));

  return jsonDecode(response.body)["result"].cast<Map<String, dynamic>>() ?? [];
}

class HitsProvider extends ChangeNotifier {
  List<TrackItem> currentList = [];

  syncNow(var link) async {
    var response = await fetchData(link);

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

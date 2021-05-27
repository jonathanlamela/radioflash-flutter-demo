import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/models/NewSongRelease.dart';

Future fetchData(dynamic link) async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(link));

  return jsonDecode(response.body)["result"].cast<Map<String, dynamic>>() ?? [];
}

class UltimeUsciteProvider extends ChangeNotifier {
  List<NewSongRelease> currentList = [];

  syncNow() async {
    var response = await fetchData(ultimeUsciteLink);

    List<NewSongRelease> responseMap = response
        .map<NewSongRelease>((e) => NewSongRelease.fromJson(e))
        .toList();

    if (currentList.isNotEmpty) {
      if (responseMap[0].titolo != currentList[0].titolo) {
        currentList = responseMap;
        notifyListeners();
      }
    } else {
      currentList = responseMap;
      notifyListeners();
    }
  }
}

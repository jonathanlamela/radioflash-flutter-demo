import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:radioflash/models/ProgrammazioneResponse.dart';

import '../RadioMeta.dart';
import 'package:http/http.dart' as http;

import '../models/ProgramItem.dart';

Future fetch() async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(onAirNowLink));

  return jsonDecode(response.body);
}

class OnAirProgramProvider extends ChangeNotifier {
  var currentProgram;
  List<ProgramItem> currentList = [];
  ProgrammazioneResponse? currentResponse;
  ProgramItem? nowProgram;

  startSync() {
    Timer.periodic(Duration(seconds: 20), (timer) async {
      await syncNow();
    });
  }

  syncNow() async {
    var response = await fetch();
    currentResponse = ProgrammazioneResponse.fromJson(response);

    if (currentList.isNotEmpty) {
      if (currentResponse!.todays[0].titolo != currentList[0].titolo ||
          nowProgram!.titolo != currentResponse!.now.titolo) {
        currentList = currentResponse!.todays;
        nowProgram = currentResponse!.now;
        notifyListeners();
      }
    } else {
      currentList = currentResponse!.todays;
      nowProgram = currentResponse!.now;
      notifyListeners();
    }
  }
}

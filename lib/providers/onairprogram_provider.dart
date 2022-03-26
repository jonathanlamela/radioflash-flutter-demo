import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/models/onair_state.dart';
import 'package:http/http.dart' as http;
import 'package:radioflash/models/programmazione_response.dart';

Future fetch() async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(onAirNowLink));

  return jsonDecode(response.body);
}

class OnAirProgramProvider extends StateNotifier<OnAirState> {
  final Ref ref;
  OnAirProgramProvider(this.ref) : super(OnAirState([], null));

  startToFetch() {
    Timer.periodic(Duration(minutes: 10), (timer) async {
      this.syncNow();
    });
  }

  syncNow() async {
    var response = ProgrammazioneResponse.fromJson(await fetch());

    if (this.state.currentList.isNotEmpty) {
      if (response.todays[0].titolo != this.state.currentList[0].titolo ||
          this.state.nowProgram!.titolo != response.now.titolo) {
        this.state = OnAirState(response.todays, response.now);
      }
    } else {
      this.state = OnAirState(response.todays, response.now);
    }
  }
}

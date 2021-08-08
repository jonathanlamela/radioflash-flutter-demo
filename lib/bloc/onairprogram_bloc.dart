import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radioflash/models/ProgrammazioneResponse.dart';

import '../RadioMeta.dart';
import 'package:http/http.dart' as http;

import '../models/ProgramItem.dart';

part 'onairprogram_event.dart';
part 'onairprogram_state.dart';

Future fetch() async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(onAirNowLink));

  return jsonDecode(response.body);
}

class OnairprogramBloc extends Bloc<OnairprogramEvent, OnairprogramState> {
  OnairprogramBloc() : super(OnairprogramInitial());

  var currentProgram;
  List<ProgramItem> currentList = [];
  ProgrammazioneResponse? currentResponse;
  ProgramItem? nowProgram;

  @override
  Stream<OnairprogramState> mapEventToState(
    OnairprogramEvent event,
  ) async* {
    if (event is OnairprogramChangedEvent) {
      yield OnAirprogramChangeState(
          currentList: currentList, nowProgram: nowProgram);
    }

    if (event is OnairprogramStartToFetchEvent) {
      Timer.periodic(Duration(minutes: 10), (timer) async {
        add(OnairprogramSyncNowEvent());
      });
    }
    if (event is OnairprogramSyncNowEvent) {
      var response = await fetch();
      currentResponse = ProgrammazioneResponse.fromJson(response);

      if (currentList.isNotEmpty) {
        if (currentResponse!.todays[0].titolo != currentList[0].titolo ||
            nowProgram!.titolo != currentResponse!.now.titolo) {
          currentList = currentResponse!.todays;
          nowProgram = currentResponse!.now;
          add(OnairprogramChangedEvent());
        }
      } else {
        currentList = currentResponse!.todays;
        nowProgram = currentResponse!.now;
        add(OnairprogramChangedEvent());
      }
    }
  }
}

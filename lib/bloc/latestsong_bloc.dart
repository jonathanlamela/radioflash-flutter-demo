import 'dart:async';

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radioflash/models/TrackItem.dart';
import 'package:http/http.dart' as http;

import '../RadioMeta.dart';

part 'latestsong_event.dart';
part 'latestsong_state.dart';

Future fetchData(dynamic currentPlaylist) async {
  var httpClient = http.Client();

  var response =
      await httpClient.get(Uri.parse(currentPlaylist["linkUltimiSuonati"]));

  return jsonDecode(response.body)["result"].cast<Map<String, dynamic>>() ?? [];
}

class LatestsongBloc extends Bloc<LatestsongEvent, LatestsongState> {
  LatestsongBloc() : super(LatestsongInitial());
  List<TrackItem> currentList = [];

  @override
  Stream<LatestsongState> mapEventToState(
    LatestsongEvent event,
  ) async* {
    if (event is LatestsongChangeEvent) {
      yield LatestsongChangeState(currentList);
    }

    if (event is LatestsongSyncNowEvent) {
      var response = await fetchData(playlist[0]);
      List<TrackItem> responseMap =
          response.map<TrackItem>((e) => TrackItem.fromJson(e)).toList();

      if (currentList.isNotEmpty) {
        if (responseMap[0].title != currentList[0].title) {
          currentList = responseMap;
          add(LatestsongChangeEvent());
        }
      } else {
        currentList = responseMap;
        add(LatestsongChangeEvent());
      }
    }

    if (event is LatestsongStartToFetchEvent) {
      Timer.periodic(Duration(seconds: 40), (timer) async {
        add(LatestsongSyncNowEvent());
      });
    }
  }
}

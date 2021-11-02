import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:radioflash/cubit/annoclassifica_cubit.dart';
import 'package:radioflash/models/Classifica.dart';

part 'classifica_event.dart';
part 'classifica_state.dart';

Future<List<Classifica>> scaricaClassifiche(anno) async {
  var httpClient = http.Client();

  var response = await httpClient
      .get(Uri.parse("https://www.imusicfun.it/wp-json/classifica/" + anno));

  var jsonResponse = jsonDecode(response.body)["items"];

  return compute(parseCharts, jsonResponse);
}

List<Classifica> parseCharts(response) {
  var list = <Classifica>[];

  list = response.map<Classifica>((e) => Classifica.fromJson(e)).toList();

  return list;
}

class ClassificaBloc extends Bloc<ClassificaEvent, ClassificaState> {
  AnnoClassificaCubit annoCubit;
  StreamSubscription<AnnoClassificaState>? streamAnno;
  ClassificaBloc(this.annoCubit) : super(ClassificaInitial()) {
    startListenAnno();
  }

  startListenAnno() {
    //inizia ad ascoltare
    this.streamAnno = this.annoCubit.stream.listen((event) {
      if (event is AnnoClassificaUpdateState) {
        add(ClassificaAnnoChangedEvent(event.Selected!));
      }
    });
  }

  stopListenAnno() {
    //smette di ascoltare
    this.streamAnno!.cancel();
  }

  @override
  Stream<ClassificaState> mapEventToState(
    ClassificaEvent event,
  ) async* {
    //chiedi tutti gli anni

    if (event is ClassificaSelectionChangedEvent) {
      //notifica la scelta di una classifica
      yield ClassificaResultsState(event.Classifiche, selected: event.Selected);
    }

    if (event is ClassificaAnnoChangedEvent) {
      var classifiche = await scaricaClassifiche(event.Anno);

      //Invia le classifiche disponibili
      yield ClassificaResultsState(classifiche, selected: classifiche.first);
    }
  }
}

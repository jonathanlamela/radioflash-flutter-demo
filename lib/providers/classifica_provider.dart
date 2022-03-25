import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/models/Classifica.dart';
import 'package:radioflash/models/classifica_state.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getYears() async {
  var httpClient = http.Client();
  var response = await httpClient
      .get(Uri.parse("https://www.imusicfun.it/wp-json/classifica/anni"));
  var jsonResponse = jsonDecode(response.body);
  var lista = jsonResponse.cast<Map<String, dynamic>>();
  return lista.map<String>((e) => e["Anno"] as String).toList();
}

Future<List<Classifica>> getCharts(anno) async {
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

class ClassificaProvider extends StateNotifier<ClassificaState> {
  final Ref ref;
  ClassificaProvider(this.ref)
      : super(ClassificaState(
            anni: [], items: [], selected: null, currentYear: null));

  downloadAnni() async {
    var anniDisponibili = await getYears();
    this.state = this
        .state
        .copyWith(anni: anniDisponibili, currentYear: anniDisponibili.first);
    await downloadCharts(anniDisponibili.first);
  }

  downloadCharts(String anno) async {
    this.state = this.state.copyWith(items: [], currentYear: anno);
    var charts = await getCharts(anno);
    this.state = this
        .state
        .copyWith(items: charts, selected: charts.first, currentYear: anno);
  }

  pickChart(Classifica item) {
    this.state = this.state.copyWith(selected: item);
  }
}

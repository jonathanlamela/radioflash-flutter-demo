import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'annoclassifica_state.dart';

Future<List<String>> anniClassifica() async {
  var httpClient = http.Client();

  var response = await httpClient
      .get(Uri.parse("https://www.imusicfun.it/wp-json/classifica/anni"));

  var jsonResponse = jsonDecode(response.body);

  var lista = jsonResponse.cast<Map<String, dynamic>>();

  return lista.map<String>((e) => e["Anno"] as String).toList();
}

class AnnoClassificaCubit extends Cubit<AnnoClassificaState> {
  List<String> Anni = [];
  AnnoClassificaCubit() : super(AnnoclassificaInitial());

  initAnni() async {
    this.Anni = await anniClassifica();
    emit(AnnoClassificaUpdateState(this.Anni, Selected: this.Anni.first));
  }

  cambiaAnno(anno) {
    emit(AnnoClassificaUpdateState(this.Anni, Selected: anno));
  }
}

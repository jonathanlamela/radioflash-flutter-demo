import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:radioflash/models/Classifica.dart';

import '../../../RadioMeta.dart';

Future<Classifica> downloadLatestChart() async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(ultimaClassificaLink));

  return compute(getFromServer, response.body);
}

Classifica getFromServer(String responseBody) {
  return Classifica.fromJson(jsonDecode(responseBody));
}

/**
class UltimaClassificaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.2))),
          child: Row(
            children: [
              Text("Ultima classifica",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: context.classificaTextStyle())
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ClassificaRender(
                          classifica: snapshot.data as Classifica)
                      : Container(height: 300, child: LoadingProgress());
                },
                future: downloadLatestChart(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
*/

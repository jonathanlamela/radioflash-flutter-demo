import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:radioflash/models/Classifica.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:radioflash/widgets/RadioSize.dart';

import '../../../RadioMeta.dart';

Future<Classifica> downloadLatestChart() async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(ultimaClassificaLink));

  return compute(getFromServer, response.body);
}

Classifica getFromServer(String responseBody) {
  return Classifica.fromJson(jsonDecode(responseBody));
}

class UltimaClassificaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            children: [
              Text("ULTIMA CLASSIFICA",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))
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

class ClassificaRender extends StatelessWidget {
  final Classifica classifica;
  const ClassificaRender({Key? key, required this.classifica})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: 8,
          ),
          child: Text(
            classifica.titolo!,
            style: TextStyle(color: Colors.white),
          ),
        ),
        CustomScrollView(
          primary: false,
          shrinkWrap: true,
          slivers: [
            SliverGrid(
                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 1200,
                  mainAxisExtent: 60,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  var item = classifica.items.elementAt(index);
                  var symbol = Icon(Icons.arrow_drop_up, color: Colors.green);

                  switch (item.movement) {
                    case "=":
                      {
                        symbol = Icon(Icons.swap_vert, color: Colors.yellow);
                      }
                      break;
                    case "up":
                      {
                        symbol =
                            Icon(Icons.arrow_upward, color: Colors.greenAccent);
                      }
                      break;
                    case "down":
                      {
                        symbol =
                            Icon(Icons.arrow_downward, color: Colors.redAccent);
                      }
                      break;
                  }
                  return Container(
                    height: 63,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${index + 1}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 16, color: Colors.white)),
                              symbol,
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: FittedBox(
                                child: item.cover,
                                fit: BoxFit.fill,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.5))
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 6,
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.titolo!,
                                        style: GoogleFonts.quicksand(
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                          children: List.generate(
                                        item.autori.length,
                                        (index) {
                                          return Text(
                                            item.autori.elementAt(index).name! +
                                                " ",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 16),
                                          );
                                        },
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }, childCount: classifica.items.take(5).length)),
          ],
        ),
        ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
            onPressed: () {},
            icon: Icon(Icons.playlist_add_check, color: Colors.white),
            label: Text(
              "Classifica completa",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

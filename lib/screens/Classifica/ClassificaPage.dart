import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/models/Classifica.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import "../../ThemeConfig.dart";
import 'package:http/http.dart' as http;

Future<List<DropdownMenuItem<String>>> anniClassifica() async {
  var httpClient = http.Client();

  var response =
      await httpClient.get(Uri.parse(dominio + "/wp-json/classifica/anni"));

  var jsonResponse = jsonDecode(response.body);

  var list = <DropdownMenuItem<String>>[];
  jsonResponse.forEach((item) {
    list.add(
      DropdownMenuItem(
        value: item["Anno"],
        child: Text(
          item["Anno"],
        ),
      ),
    );
  });

  return list;
}

Future<List<Classifica>> scaricaClassifiche(anno) async {
  var httpClient = http.Client();

  var response =
      await httpClient.get(Uri.parse(dominio + "/wp-json/classifica/" + anno));

  var jsonResponse = jsonDecode(response.body)["items"];

  return compute(parseCharts, jsonResponse);
}

List<Classifica> parseCharts(response) {
  var list = <Classifica>[];

  list = response.map<Classifica>((e) => Classifica.fromJson(e)).toList();

  return list;
}

class ClassificaPage extends StatefulWidget {
  ClassificaPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ClassificaPageState();
  }
}

class ClassificaPageState extends State<ClassificaPage> {
  String? annoSelezionato;
  List<Classifica> charts = [];
  Classifica? currentChart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 24, left: 10, right: 10),
              decoration: context.homeContainerStyle(),
              padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.white, width: 0.2))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Classifica",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              style: context.classificaPageTextStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnnoControls(
                    current: annoSelezionato,
                    onAnnoSelected: (anno) async {
                      var items = await scaricaClassifiche(anno);
                      setState(() {
                        this.charts = items;
                        this.annoSelezionato = anno;
                        this.currentChart = this.charts.first;
                      });
                    },
                  ),
                  ClassificaControls(
                    charts: charts,
                    current: currentChart,
                    onClassificaChange: (chart) {
                      setState(() {
                        this.currentChart = chart;
                      });
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: ClassificaRender(
                            key: UniqueKey(),
                            classifica: currentChart,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnnoControls extends StatelessWidget {
  String? current;
  Function? onAnnoSelected;
  AnnoControls({Key? key, this.current, this.onAnnoSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "Anno",
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var items = snapshot.data as List<DropdownMenuItem<String>>;
                if (current == null) {
                  this.current = items.first.value;
                  this.onAnnoSelected!(this.current);
                }
                return Expanded(
                  child: Container(
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white),
                      value: current,
                      onChanged: (value) {},
                      items: items,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
            future: anniClassifica(),
          )
        ],
      ),
    );
  }
}

class ClassificaControls extends StatelessWidget {
  Classifica? current;
  Function? onClassificaChange;
  ClassificaControls(
      {Key? key, this.current, this.onClassificaChange, this.charts})
      : super(key: key);
  List<Classifica>? charts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "Classifica",
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: DropdownButton(
                isExpanded: true,
                dropdownColor: Colors.black,
                style: TextStyle(color: Colors.white),
                value: current,
                onChanged: (value) {
                  onClassificaChange!(value);
                },
                items: List.generate(charts!.length, (index) {
                  return DropdownMenuItem(
                    value: charts!.elementAt(index),
                    child: Text(
                      charts!.elementAt(index).titolo!,
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClassificaRender extends StatelessWidget {
  Classifica? classifica;
  ClassificaRender({Key? key, required this.classifica}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (classifica != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          classifica!.items.length,
          (index) {
            var item = classifica!.items.elementAt(index);
            var symbol = Icon(Icons.arrow_drop_up, color: Colors.green);

            switch (item.movement) {
              case "=":
                {
                  symbol = Icon(Icons.swap_vert, color: Colors.yellow);
                }
                break;
              case "up":
                {
                  symbol = Icon(Icons.arrow_upward, color: Colors.greenAccent);
                }
                break;
              case "down":
                {
                  symbol = Icon(Icons.arrow_downward, color: Colors.redAccent);
                }
                break;
            }
            return Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${index + 1}",
                            style: context.classificaNumeroTextStyle()),
                        symbol,
                      ],
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                        margin: EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          child: FittedBox(
                            child: item.cover,
                            fit: BoxFit.fill,
                          ),
                        ),
                        decoration: context.classificaCoverDecoration()),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.titolo!,
                                  style: context.classificaSongTitleTextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(children: [
                                  Flexible(
                                    child: Text(
                                      stringAutori(item.autori),
                                      overflow: TextOverflow.ellipsis,
                                      style: context
                                          .classificaSongAuthorsTextStyle(),
                                    ),
                                  )
                                ]),
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
          },
        ),
      );
    } else {
      return LoadingProgress();
    }
  }

  String stringAutori(autori) {
    String result = "";

    List.generate(autori.length, (index) {
      result += autori.elementAt(index).name! +
          (autori.length > 1 && index < autori.length - 1 ? " & " : "");
    });

    return result;
  }
}

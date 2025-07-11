import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/models/news_item.dart';
import 'package:radioflash/widgets/loading_progress.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../ThemeConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<NewsItem>> downloadArticoli() async {
  var httpClient = http.Client();
  var response = await httpClient.get(Uri.parse(newsLink));

  var responseContent =
      jsonDecode(response.body).cast<Map<String, dynamic>>() ?? [];

  return compute(parseData, responseContent);
}

List<NewsItem> parseData(responseBody) {
  return responseBody.map<NewsItem>((e) => NewsItem.fromJson(e)).toList();
}

class Notizie extends StatelessWidget {
  Notizie({Key? key}) : super(key: key);
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
              decoration: BoxDecoration(
                color: context.homeContainerColor(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
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
                    child: Row(
                      children: [
                        Text(
                          "Ultime notizie",
                          textScaler: MediaQuery.of(context).textScaler,
                          style: context.ultimiSuonatiPlaylistTextStyle(),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: List.generate(
                                (snapshot.data as List).length,
                                (index) {
                                  NewsItem item =
                                      (snapshot.data as List).elementAt(index);
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child:
                                        (MediaQuery.of(context).size.width > 600
                                            ? RowTabletVersion(item: item)
                                            : RowMobileVersion(item: item)),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Container(
                              height: 300,
                              child: LoadingProgress(),
                            );
                          }
                        },
                        future: downloadArticoli(),
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

class RowMobileVersion extends StatelessWidget {
  const RowMobileVersion({
    Key? key,
    required this.item,
  }) : super(key: key);

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: item.cover!.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                  color: context.themePrimary(),
                  width: 100,
                  height: 30,
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('d MMM y', 'it_IT').format(item.data!),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Html(
                      data: "<p>" + item.titolo! + "</p>",
                      style: {
                        "p": Style(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.justify,
                            margin: Margins.all(0))
                      },
                    ),
                    Html(
                      data: item.estratto!,
                      style: {
                        "p": Style(
                            textAlign: TextAlign.justify,
                            margin: Margins.all(0),
                            color: Colors.white)
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.themePrimary()),
                      onPressed: () {
                        launchUrlString(item.link!);
                      },
                      child: Text(
                        "Leggi",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class RowTabletVersion extends StatelessWidget {
  const RowTabletVersion({
    Key? key,
    required this.item,
  }) : super(key: key);

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Stack(
            children: [
              Container(
                height: 170,
                width: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: item.cover!.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                  color: context.themePrimary(),
                  width: 100,
                  height: 30,
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('d MMM y', 'it_IT').format(item.data!),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Html(
                      data: "<p>" + item.titolo! + "</p>",
                      style: {
                        "p": Style(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.justify,
                            margin: Margins.all(0))
                      },
                    ),
                    Flexible(
                      child: Html(
                        data: item.estratto!,
                        style: {
                          "p": Style(
                              textAlign: TextAlign.justify,
                              margin: Margins.all(0),
                              color: Colors.white)
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.themePrimary()),
                      onPressed: () {
                        launchUrlString(item.link!);
                      },
                      child: Text(
                        "Leggi",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

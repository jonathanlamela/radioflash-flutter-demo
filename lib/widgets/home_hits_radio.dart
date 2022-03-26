import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/tracking_item.dart';
import 'package:radioflash/widgets/home_playlist_item.dart';
import 'package:radioflash/widgets/loading_progress.dart';

import 'package:http/http.dart' as http;

Future<List<TrackItem>> fetchData(dynamic link) async {
  var httpClient = http.Client();
  var response = await httpClient.get(Uri.parse(link));
  return compute(parseResult, response.body);
}

List<TrackItem> parseResult(response) {
  return jsonDecode(response)["result"]
      .cast<Map<String, dynamic>>()
      .map<TrackItem>((e) => TrackItem.fromJson(e))
      .toList();
}

class HomeHitsRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.2))),
          child: Row(
            children: [Text("Hits", style: context.hitsTextStyle())],
          ),
        ),
        Container(
          width: double.infinity,
          child: Container(
            child: FutureBuilder(
              future: fetchData(hitsLink),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? HitsList(
                        items: (snapshot.data as Iterable<TrackItem>)
                            .where((element) => element.isSong == true)
                            .toList()
                            .skip(1)
                            .take(6),
                      )
                    : LoadingProgress();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class HitsList extends StatelessWidget {
  const HitsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final Iterable<TrackItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey<String?>(items.first.title),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomScrollView(
          primary: false,
          shrinkWrap: true,
          slivers: [
            SliverGrid(
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 600,
                mainAxisExtent: 60,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return HomePlaylistItem(item: items.elementAt(index));
              }, childCount: items.length),
            ),
          ],
        )
      ],
    );
  }
}

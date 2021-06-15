import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radioflash/RadioMeta.dart';
import 'package:radioflash/models/NewSongRelease.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';
import 'package:http/http.dart' as http;

import '../../../ThemeConfig.dart';

Future<List<NewSongRelease>> fetchData(dynamic link) async {
  var httpClient = http.Client();

  var response = await httpClient.get(Uri.parse(link));

  var responseContent =
      jsonDecode(response.body)["result"].cast<Map<String, dynamic>>() ?? [];

  return compute(parseData, responseContent);
}

List<NewSongRelease> parseData(responseBody) {
  return responseBody
      .map<NewSongRelease>((e) => NewSongRelease.fromJson(e))
      .toList();
}

class UltimeUscite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;

    if (mediaQuerySize.width > 600) {
      return UltimeUsciteTablet();
    } else if (mediaQuerySize.width > 300) {
      return UltimeUsciteMobile();
    } else {
      return UltimeUsciteMobile();
    }
  }
}

class UltimeUsciteMobile extends StatelessWidget {
  const UltimeUsciteMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            children: [
              Text(
                "Novità RadioFlash",
                style: context.novitaTextStyle(),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: context.novitaCardColor(),
                borderOnForeground: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    child: FutureBuilder(
                      future: fetchData(ultimeUsciteLink),
                      builder: (context, snapshot) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 600),
                          child: snapshot.hasData
                              ? NewReleasesList(
                                  items: (snapshot.data as List<NewSongRelease>)
                                      .where((element) => element.cover != null)
                                      .toList())
                              : LoadingProgress(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NewReleasesList extends StatelessWidget {
  const NewReleasesList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<NewSongRelease> items;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      await showGeneralDialog(
                        transitionDuration: Duration(milliseconds: 200),
                        context: context,
                        barrierLabel: '',
                        barrierDismissible: true,
                        barrierColor: Colors.white70,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Row();
                        },
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: NewReleaseDialog(
                                  item: items.elementAt(index)),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: items.elementAt(index).cover,
                    ),
                  );
                },
                childCount: 12,
              ),
            ),
          ],
        ),
        Container(
          height: 0,
        )
      ],
    );
  }
}

class NewReleaseDialog extends StatelessWidget {
  const NewReleaseDialog({Key? key, required this.item}) : super(key: key);

  final NewSongRelease item;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          child: Container(
            color: Colors.transparent,
            height: 400,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: item.cover!.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: context.ultimeUsciteContainerColor(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.titolo,
                              style: context.ultimeUsciteTitleTextStyle(),
                            ),
                            Text(
                              item.artista,
                              style: context.ultimeUsciteArtistTextStyle(),
                            ),
                            Text(
                              DateFormat('d/MM/y').format(item.radioDate!),
                              style: context.ultimeUsciteRadioDateTextStyle(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UltimeUsciteTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                "Novità RadioFlash",
                style: context.novitaTextStyle(),
              )
            ],
          ),
        ),
        Container(
          child: Container(
              child: FutureBuilder(
            future: fetchData(ultimeUsciteLink),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: snapshot.hasData
                    ? NewReleasesListTablet(
                        items: (snapshot.data as List<NewSongRelease>)
                            .where((element) => element.cover != null)
                            .take(6)
                            .toList(),
                      )
                    : LoadingProgress(),
              );
            },
          )),
        ),
      ],
    );
  }
}

class NewReleasesListTablet extends StatelessWidget {
  const NewReleasesListTablet({
    Key? key,
    required this.items,
  }) : super(key: key);

  final Iterable<NewSongRelease> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey<String?>(items.first.titolo),
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
                mainAxisExtent: 63,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                var item = items.elementAt(index);
                return Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              boxShadow: [context.shadownForDark()],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.titolo,
                                  style: context
                                      .ultimeUsciteTabletTitleTextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.artista,
                                  overflow: TextOverflow.ellipsis,
                                  style: context
                                      .ultimeUsciteTabletArtistTextStyle(),
                                ),
                                if (item.radioDate == DateTime.now())
                                  Chip(
                                    backgroundColor:
                                        context.ultimeUsciteOggiChipColor(),
                                    label: Text(
                                      "OGGI",
                                      style:
                                          context.ultimeUsciteChipTextStyle(),
                                    ),
                                  ),
                                if (item.radioDate != DateTime.now())
                                  Text(
                                      DateFormat('d/MM/y')
                                          .format(item.radioDate!),
                                      overflow: TextOverflow.ellipsis,
                                      style: context
                                          .ultimeUsciteTabletRadioDateTextStyle()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              }, childCount: items.length),
            ),
          ],
        )
      ],
    );
  }
}

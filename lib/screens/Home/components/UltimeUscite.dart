import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/models/NewSongRelease.dart';
import 'package:radioflash/services/UltimeUsciteProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';

import '../../../ThemeConfig.dart';

class UltimeUscite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                "NOVITA' RADIOFLASH",
                style: TextStyle(
                    fontFamily: GoogleFonts.quicksand().fontFamily,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white60,
                borderOnForeground: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    child: Consumer<UltimeUsciteProvider>(
                      builder: (context, value, child) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 600),
                          child: value.currentList.isNotEmpty
                              ? NewReleasesList(
                                  items: value.currentList
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
                    color: themePrimary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.titolo,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              item.artista,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.anton().fontFamily,
                              ),
                            ),
                            Text(
                              DateFormat('d/MM/y').format(item.radioDate!),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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

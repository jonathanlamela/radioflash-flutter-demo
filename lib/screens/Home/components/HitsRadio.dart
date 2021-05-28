import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/TrackItem.dart';
import 'package:radioflash/services/HitsProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';

import '../../../widgets/PlaylistListItem.dart';

class HitsRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            children: [Text("HITS", style: context.hitsTextStyle())],
          ),
        ),
        Container(
          width: double.infinity,
          child: Container(
            child: Consumer<HitsProvider>(
              builder: (context, value, child) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  child: value.currentList.isNotEmpty
                      ? HitsList(
                          items: value.currentList
                              .where((element) => element.isSong == true)
                              .toList()
                              .skip(1)
                              .take(6))
                      : LoadingProgress(),
                );
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
                return PlaylistItem(item: items.elementAt(index));
              }, childCount: items.length),
            ),
          ],
        )
      ],
    );
  }
}

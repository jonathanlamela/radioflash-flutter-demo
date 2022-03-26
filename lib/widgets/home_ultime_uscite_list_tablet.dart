import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radioflash/ThemeConfig.dart';
import 'package:radioflash/models/new_song_release.dart';

class HomeUltimeUsciteListTablet extends StatelessWidget {
  const HomeUltimeUsciteListTablet({
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

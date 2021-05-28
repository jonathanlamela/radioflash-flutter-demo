import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radioflash/models/TrackItem.dart';

class UltimiSuonatiList extends StatelessWidget {
  const UltimiSuonatiList({
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
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
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
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.artist,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                Text(
                                  "${item.quantiMinutiFa!} minuti fa"
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: items.length)),
          ],
        )
      ],
    );
  }
}

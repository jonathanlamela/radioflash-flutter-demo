import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/models/NewSongRelease.dart';
import 'package:radioflash/services/UltimeUsciteProvider.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';

class UltimeUsciteTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            children: [
              Text("NOVITA' RADIOFLASH",
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
          child: Container(
            child: Consumer<UltimeUsciteProvider>(
              builder: (context, value, child) {
                return AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: value.currentList.isNotEmpty
                        ? NewReleasesListTablet(
                            items: value.currentList.toList().take(6),
                          )
                        : LoadingProgress());
              },
            ),
          ),
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
                                  item.titolo,
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.artista,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                if (item.radioDate == DateTime.now())
                                  Chip(
                                    backgroundColor: Colors.red[700],
                                    label: Text(
                                      "OGGI",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                if (item.radioDate != DateTime.now())
                                  Text(
                                    DateFormat('d/MM/y')
                                        .format(item.radioDate!),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                    ),
                                  ),
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

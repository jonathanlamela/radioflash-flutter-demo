import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/models/TrackItem.dart';
import 'package:radioflash/widgets/LoadingProgress.dart';

import '../../../services/OnAirLatestSongProvider.dart';

class CanzoneInOnda extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CanzoneInOndaState();
  }
}

class CanzoneInOndaState extends State<CanzoneInOnda> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            "ORA IN ONDA",
            style: TextStyle(
                fontFamily: GoogleFonts.quicksand().fontFamily,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Consumer<OnAirLatestSongProvider>(
                  builder: (context, value, child) {
                    return AnimatedSwitcher(
                      child: value.currentList.isNotEmpty
                          ? SongInfo(item: value.currentList.first)
                          : LoadingProgress(),
                      duration: Duration(milliseconds: 800),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SongInfo extends StatelessWidget {
  const SongInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TrackItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      key: ValueKey(item.title),
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
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
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(blurRadius: 5, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.quicksand().fontFamily),
                ),
                Text(
                  item.artist,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: GoogleFonts.quicksand().fontFamily,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

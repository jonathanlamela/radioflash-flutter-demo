import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/ThemeConfig.dart';
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
          width: double.infinity,
          padding: EdgeInsets.only(top: 8, bottom: 8),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 0.2),
            ),
          ),
          child: Text(
            "ORA IN ONDA",
            style: context.oraInOndaTextStyle(),
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
                decoration: context.canzoneInOndaDecoration()),
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
                Text(item.title,
                    overflow: TextOverflow.ellipsis,
                    style: context.oraInOndaSongTitle()),
                Text(
                  item.artist,
                  overflow: TextOverflow.ellipsis,
                  style: context.oraInOndaSongArtist(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../models/TrackItem.dart';
import '../ThemeConfig.dart';

class PlaylistItem extends StatelessWidget {
  final TrackItem item;
  PlaylistItem({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
                    item.title,
                    style: context.playlistItemTitleTextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.artist,
                    overflow: TextOverflow.ellipsis,
                    style: context.playlistItemArtistTextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

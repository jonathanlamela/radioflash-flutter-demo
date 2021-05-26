import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ThemeConfig.dart';
import '../../services/PlayerProvider.dart';
import '../../services/PlayerProvider.dart';
import 'RPBAnimatedCover.dart';

class RPBSongInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainContent = Consumer<PlayerProvider>(
      builder: (context, value, child) {
        Widget child = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        );

        if (value.currentList.isNotEmpty) {
          child = Container(
            key: UniqueKey(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: RPBAnimatedCover(
                        isPlaying: value.isPlaying,
                        image: value.currentList.first.cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          value.currentList.first.title,
                          style: tBottomPlayerSongTitle,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          value.currentList.first.artist,
                          style: tBottomPlayerSongArtist,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return AnimatedSwitcher(
          child: child,
          duration: Duration(milliseconds: 700),
        );
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Flexible(child: mainContent)],
          ),
        ),
      ],
    );
  }
}

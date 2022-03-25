import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/provider.dart';

import '../../ThemeConfig.dart';
import 'radio_bottom_player_animatedcover.dart';

class RadioBottomPlayerSongInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentList =
        ref.watch(playerStatusProvider.select((value) => value.currentList));
    var isPlaying =
        ref.watch(playerStatusProvider.select((value) => value.isPlaying));

    Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );

    if (currentList.isNotEmpty) {
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
                child: RadioBottomPlayerAnimatedCover(
                    isPlaying: isPlaying, image: currentList.first.cover),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      currentList.first.title,
                      style: context.playerSongTitleTextStyle(),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      currentList.first.artist,
                      style: context.playerSongArtistTextStyle(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    var mainContent = AnimatedSwitcher(
      child: child,
      duration: Duration(milliseconds: 700),
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

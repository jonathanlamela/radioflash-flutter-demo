import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/provider.dart';

import '../../ThemeConfig.dart';

class RadioBottomPlayerPlayButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Rebuild " + this.runtimeType.toString());
    var isPlaying =
        ref.watch(playerStatusProvider.select((value) => value.isPlaying));
    var content = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: context.playPauseButtonColor(),
            child: IconButton(
                icon: (!isPlaying
                    ? Icon(
                        Icons.play_arrow_rounded,
                      )
                    : Icon(
                        Icons.pause,
                      )),
                color: context.playPauseButtonIconColor(),
                onPressed: () {
                  ref
                      .read(playerStatusProvider.notifier)
                      .setIsPlaying(!isPlaying);
                }),
          )
        ],
      ),
    );

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Flexible(child: content)]))
        ]);
  }
}

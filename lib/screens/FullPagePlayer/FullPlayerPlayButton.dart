import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/bloc/player_bloc.dart';
import '../../ThemeConfig.dart';

class FullPlayerPlayButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullPlayerPlayButtonState();
  }
}

class FullPlayerPlayButtonState extends State<FullPlayerPlayButton> {
  var isPlaying = false;
  @override
  Widget build(BuildContext context) {
    isPlaying = context.watch<PlayerBloc>().isPlaying;
    var content = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                color: Colors.transparent,
                shape: BoxShape.circle),
            child: IconButton(
                icon: (isPlaying != true
                    ? Icon(
                        Icons.play_arrow_rounded,
                      )
                    : Icon(
                        Icons.pause,
                      )),
                color: context.playPauseButtonIconColor(),
                onPressed: () {
                  if (isPlaying) {
                    context
                        .read<PlayerBloc>()
                        .add(PlayerPlayingChangeEvent(isPlaying: false));
                  } else {
                    context
                        .read<PlayerBloc>()
                        .add(PlayerPlayingChangeEvent(isPlaying: true));
                  }
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

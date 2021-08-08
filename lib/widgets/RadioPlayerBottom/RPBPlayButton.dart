import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/bloc/player_bloc.dart';

import '../../ThemeConfig.dart';

class RPBPlayButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RPBPlayButtonState();
  }
}

class RPBPlayButtonState extends State<RPBPlayButton> {
  var isPlaying = false;
  @override
  Widget build(BuildContext context) {
    var content = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<PlayerBloc, PlayerState>(
            buildWhen: (previous, current) {
              return current is PlayerPlayingChangeState;
            },
            builder: (context, state) {
              return CircleAvatar(
                backgroundColor: context.playPauseButtonColor(),
                child: IconButton(
                    icon: (state.isPlaying != true
                        ? Icon(
                            Icons.play_arrow_rounded,
                          )
                        : Icon(
                            Icons.pause,
                          )),
                    color: context.playPauseButtonIconColor(),
                    onPressed: () {
                      if (state.isPlaying) {
                        context
                            .read<PlayerBloc>()
                            .add(PlayerPlayingChangeEvent(isPlaying: false));
                      } else {
                        context
                            .read<PlayerBloc>()
                            .add(PlayerPlayingChangeEvent(isPlaying: true));
                      }
                    }),
              );
            },
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

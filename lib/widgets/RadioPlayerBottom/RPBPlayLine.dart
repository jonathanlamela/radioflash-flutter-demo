import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioflash/bloc/player_bloc.dart';

import '../../ThemeConfig.dart';

class RPBPlayLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previous, current) {
        return current is PlayerPlayingChangeState;
      },
      builder: (context, state) {
        return LinearProgressIndicator(
          backgroundColor: context.playlineBackgroundColor(),
          valueColor:
              new AlwaysStoppedAnimation<Color?>(context.playlineValueColor()),
          value: (state.isPlaying == true ? null : 0),
          semanticsLabel: 'Linear progress indicator',
        );
      },
    );
  }
}

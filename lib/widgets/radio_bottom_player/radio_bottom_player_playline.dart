import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioflash/provider.dart';

import '../../ThemeConfig.dart';

class RadioBottomPlayerPlayLine extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //rebuild questo widget solo quando cambia il valore di isPlaying
    var isPlaying =
        ref.watch(playerStatusProvider.select((value) => value.isPlaying));
    return LinearProgressIndicator(
      backgroundColor: context.playlineBackgroundColor(),
      valueColor:
          new AlwaysStoppedAnimation<Color?>(context.playlineValueColor()),
      value: (isPlaying == true ? null : 0),
      semanticsLabel: 'Linear progress indicator',
    );
  }
}

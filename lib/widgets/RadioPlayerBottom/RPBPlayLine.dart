import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ThemeConfig.dart';
import '../../services/PlayerProvider.dart';

class RPBPlayLine extends StatelessWidget {
  var isPlaying = false;

  @override
  Widget build(BuildContext context) {
    isPlaying = Provider.of<PlayerProvider>(context, listen: true).isPlaying;
    return LinearProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: new AlwaysStoppedAnimation<Color?>(themePrimary),
      value: (isPlaying == true ? null : 0),
      semanticsLabel: 'Linear progress indicator',
    );
  }
}

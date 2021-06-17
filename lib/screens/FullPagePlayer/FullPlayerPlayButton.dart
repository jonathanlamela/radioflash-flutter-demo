import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioflash/services/PlayerProvider.dart';
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
    isPlaying = Provider.of<PlayerProvider>(context, listen: true).isPlaying;
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
                    Provider.of<PlayerProvider>(context, listen: false).stop();
                  } else {
                    Provider.of<PlayerProvider>(context, listen: false).play();
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

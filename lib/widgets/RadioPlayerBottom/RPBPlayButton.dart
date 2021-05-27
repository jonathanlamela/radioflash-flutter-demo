import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/PlayerProvider.dart';

class RPBPlayButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RPBPlayButtonState();
  }
}

class RPBPlayButtonState extends State<RPBPlayButton>
    with WidgetsBindingObserver {
  var isPlaying = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addObserver(this);
    isPlaying = Provider.of<PlayerProvider>(context, listen: true).isPlaying;
    var content = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade900,
            child: IconButton(
                icon: (isPlaying != true
                    ? Icon(
                        Icons.play_arrow_rounded,
                      )
                    : Icon(
                        Icons.pause,
                      )),
                color: Colors.white,
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

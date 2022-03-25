import 'package:flutter/material.dart';

import 'radio_bottom_player_songinfo.dart';
import 'radio_bottom_player_playline.dart';
import 'radio_bottom_player_playbutton.dart';
import '../../ThemeConfig.dart';

class RadioBottomPlayerWidget extends StatefulWidget {
  RadioBottomPlayerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RadioBottomPlayerWidgetState();
  }
}

class RadioBottomPlayerWidgetState extends State<RadioBottomPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'fullpageplayer');
          },
          child: Container(
            decoration: BoxDecoration(
              color: context.playerBackgroundColor(),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 60,
            child: Material(
              color: context.playerBackgroundColor(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(flex: 4, child: RadioBottomPlayerSongInfo()),
                  Flexible(flex: 2, child: RadioBottomPlayerPlayButton()),
                ],
              ),
            ),
          ),
        ),
        RadioBottomPlayerPlayLine(),
      ],
    );
  }
}

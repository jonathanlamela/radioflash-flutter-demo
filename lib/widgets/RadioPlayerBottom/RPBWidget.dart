import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:radioflash/ThemeConfig.dart';

import 'RPBSongInfo.dart';
import 'RPBPlayLine.dart';
import 'RPBPlayButton.dart';

class RPBWidget extends StatefulWidget {
  RPBWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RPBWidgetState();
  }
}

class RPBWidgetState extends State<RPBWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
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
            color: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 4, child: RPBSongInfo()),
                Flexible(flex: 2, child: RPBPlayButton()),
              ],
            ),
          ),
        ),
        RPBPlayLine(),
      ],
    );
  }
}

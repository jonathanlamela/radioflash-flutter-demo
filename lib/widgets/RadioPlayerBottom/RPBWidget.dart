import 'dart:ui';

import 'package:flutter/material.dart';

import 'RPBSongInfo.dart';
import 'RPBPlayLine.dart';
import 'RPBPlayButton.dart';
import '../../ThemeConfig.dart';

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
                  Flexible(flex: 4, child: RPBSongInfo()),
                  Flexible(flex: 2, child: RPBPlayButton()),
                ],
              ),
            ),
          ),
        ),
        RPBPlayLine(),
      ],
    );
  }
}

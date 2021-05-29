import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ThemeConfig.dart';

class RadioTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.statusBarColor(),
      padding: EdgeInsets.only(bottom: 24, top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: context.logoImmagine(),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Radio ",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text("FLASH",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: GoogleFonts.anton().fontFamily)),
                  ],
                ),
                Text("La Radio Che Funziona",
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

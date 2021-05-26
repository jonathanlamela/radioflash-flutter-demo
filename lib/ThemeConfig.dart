import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var themePrimary = Colors.grey[900];
Color themeMenuHoverColor = Colors.grey;
Color themeNormalItemHinting = Colors.black;
Color? themeSelectedItemHinting = Colors.grey[500];
Color? themeHomeHoverButtonColor = Colors.yellow[600];

Color menuItemNormalHintingColor = Colors.black;
Color menuItemNormalBackGroundCOlor = Colors.white;
Color menuItemSelectedHintingColor = Colors.white;
Color? menuItemSelectedBackgroundColor = Colors.grey[500];
Color menuItemHoverColor = Colors.grey;

TextStyle tBottomPlayerSongTitle = TextStyle(
  color: Colors.white,
  fontSize: 12,
);
TextStyle tBottomPlayerSongArtist =
    TextStyle(color: Colors.white, fontSize: 10);

var themeBodyDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ],
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(5),
  ),
);

TextStyle homeTitlesTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.raleway().fontFamily);
Color topIconColor = Colors.white;
TextStyle topTextIconStyle =
    TextStyle(fontFamily: GoogleFonts.anton().fontFamily, color: topIconColor);

String? themeFontFamily = GoogleFonts.roboto().fontFamily;
var logoImmagine = Image.asset("images/logo.png", height: 60);

import 'package:flutter/material.dart';

double getSliderHeight(BuildContext context) {
  var mediaQuerySize = MediaQuery.of(context).size;

  if (mediaQuerySize.width > 600) {
    return 450;
  } else if (mediaQuerySize.width > 300) {
    return 300;
  } else {
    return 300;
  }
}

double getSliderViewportFraction(BuildContext context) {
  var mediaQuerySize = MediaQuery.of(context).size;

  if (mediaQuerySize.width > 600) {
    return 0.8;
  } else if (mediaQuerySize.width > 300) {
    return 0.8;
  } else {
    return 0.5;
  }
}

getClassificaHeight(context) {
  var mediaQuerySize = MediaQuery.of(context).size;

  if (mediaQuerySize.width > 600) {
    return 240.0;
  } else if (mediaQuerySize.width > 300) {
    return 380.0;
  } else {
    return 300.0;
  }
}

getUltimiSuonatiHeight(context) {
  var mediaQuerySize = MediaQuery.of(context).size;

  if (mediaQuerySize.width > 600) {
    return 190.0;
  } else if (mediaQuerySize.width > 300) {
    return 380.0;
  } else {
    return 300.0;
  }
}

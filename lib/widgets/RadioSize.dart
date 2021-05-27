import 'package:flutter/material.dart';

double getSliderHeight(BuildContext context) {
  var mediaQuerySize = MediaQuery.of(context).size;

  if (mediaQuerySize.width > 900) {
    return 450;
  } else {
    return 300;
  }
}

double getSliderViewportFraction(BuildContext context) {
  var mediaQuerySize = MediaQuery.of(context).size;

  if (mediaQuerySize.width > 700) {
    return 0.5;
  } else {
    return 0.8;
  }
}

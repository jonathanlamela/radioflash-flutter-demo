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

  print(mediaQuerySize.width);
  if (mediaQuerySize.width > 600) {
    return 0.8;
  } else if (mediaQuerySize.width > 300) {
    return 0.8;
  } else {
    return 0.5;
  }
}

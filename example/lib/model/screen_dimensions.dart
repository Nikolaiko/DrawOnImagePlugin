import 'package:flutter/material.dart';

class ScreenDimensions {
  double width = 0;
  double fullHeight = 0;
  double withoutSafeAreaHeight = 0;

  ScreenDimensions(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    fullHeight = MediaQuery.of(context).size.height;

    var padding = MediaQuery.of(context).padding;
    withoutSafeAreaHeight = fullHeight - padding.top - padding.bottom;
  }
}
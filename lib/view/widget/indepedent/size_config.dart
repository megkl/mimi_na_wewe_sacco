import 'package:flutter/material.dart';

class SizeConfiguration {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

//Get the proportional height as per screen size
double getProportionalScreenHeight(double inputHeight) {
  double screenHeight = SizeConfiguration.screenHeight;

//812 is the layout height used by designers
  return (inputHeight / 812.0) * screenHeight;
}

//Get the proportional width as per screen size
double getProportionalScreenWidth(double inputWidth) {
  double screenWidth = SizeConfiguration.screenWidth;

//375 is the layout height used by designers
  return (inputWidth / 375.0) * screenWidth;
}

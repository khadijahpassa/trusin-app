import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = MediaQueryData.fromView(
    // ignore: deprecated_member_use
    WidgetsBinding.instance.window
  );

  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double defaultSize = 0.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  //   Fungsi yang digunakan untuk mendapatkan ukuran tinggi layar yang proporsional
  double getProportionateScreenHight(double inputHight) {
    double screenHeight = SizeConfig.screenHeight;
    return (inputHight / 812.0) * screenHeight; // 812.0 tinggi layout yg umum digunakan oleh programmer
  }

  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth;
    return (screenWidth / 375.0) * inputWidth; // 375.0 lebar layout yg umum digunakan oleh programmer
  }
}
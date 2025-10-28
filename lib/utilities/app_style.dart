import 'package:flutter/material.dart';

  class AppStyles {
  static TextStyle getExtraLightTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
  return TextStyle(
  fontSize: fontSize,
  fontFamily: isCurrency ? null : "Montserrat",
  color: color,
  fontWeight: FontWeight.w200,
  );
  }

  static TextStyle getLightTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
  return TextStyle(
  fontSize: fontSize,
  fontFamily: isCurrency ? null : "Montserrat",
  color: color,
  fontWeight: FontWeight.w300,
  );
  }

  static TextStyle getRegularTextStyle({required double fontSize, Color? color, bool isCurrency = false, TextDecoration? decoration, Color? decorationColor}) {
  return TextStyle(
  fontSize: fontSize,
  fontFamily: isCurrency ? null : "Montserrat",
  color: color,
  fontWeight: FontWeight.w400,
  decoration: decoration,
  decorationColor: decorationColor,
  );
  }

  static TextStyle getBoldTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
  return TextStyle(
  fontSize: fontSize,
  fontFamily: isCurrency ? null : "Montserrat",
  fontWeight: FontWeight.w700,
  color: color,
  );
  }

  static TextStyle getSemiBoldTextStyle({required double fontSize, Color? color, bool isCurrency = false, TextDecoration? decoration, Color? decorationColor}) {
  return TextStyle(fontSize: fontSize, fontFamily: isCurrency ? null : "Montserrat", fontWeight: FontWeight.w600, color: color, decoration: decoration, decorationColor: decorationColor);
  }

  static TextStyle getMediumTextStyle({required double fontSize, Color? color, bool isCurrency = false, double? height, TextDecoration? textDecoration}) {
  return TextStyle(
  fontSize: fontSize,
  fontFamily: isCurrency ? null : "Montserrat",
  fontWeight: FontWeight.w500,
  decoration: textDecoration,
  height: height,
  color: color,
  );
  }
  }

import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  double? height,
  Color color,
  double? letterSpacing,
) =>
    TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'DMSans',
        height: height,
        letterSpacing: letterSpacing);

TextStyle getLightStyle(
        {double? fontSize,
        double? height,
        required Color color,
        double? letterSpacing}) =>
    _getTextStyle(fontSize ?? FontSize.s13, FontWeightManager.light, height,
        color, letterSpacing);

TextStyle getRegularStyle(
        {double? fontSize,
        double? height,
        required Color color,
        double? letterSpacing}) =>
    _getTextStyle(fontSize ?? FontSize.s13, FontWeightManager.regular, height,
        color, letterSpacing);

TextStyle getMediumStyle(
        {double? fontSize,
        double? height,
        required Color color,
        double? letterSpacing}) =>
    _getTextStyle(fontSize ?? FontSize.s13, FontWeightManager.medium, height,
        color, letterSpacing);

TextStyle getSemiBoldStyle(
        {double? fontSize,
        double? height,
        required Color color,
        double? letterSpacing}) =>
    _getTextStyle(fontSize ?? FontSize.s13, FontWeightManager.semiBold, height,
        color, letterSpacing);

TextStyle getBoldStyle(
        {double? fontSize,
        double? height,
        required Color color,
        double? letterSpacing}) =>
    _getTextStyle(fontSize ?? FontSize.s13, FontWeightManager.bold, height,
        color, letterSpacing);

TextStyle getTextWithLine() => TextStyle(
      color: ColorManager.black,
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: ColorManager.black,
      fontFamily: 'DMSans',
    );

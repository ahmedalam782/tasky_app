import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  double? height,
  Color color,
) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: 'DMSans',
      height: height,
    );

TextStyle getLightStyle({
  double? fontSize,
  double? height,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? FontSize.s13,
      FontWeightManager.light,
      height,
      color,
    );

TextStyle getRegularStyle({
  double? fontSize,
  double? height,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? FontSize.s13,
      FontWeightManager.regular,
      height,
      color,
    );

TextStyle getMediumStyle({
  double? fontSize,
  double? height,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? FontSize.s13,
      FontWeightManager.medium,
      height,
      color,
    );

TextStyle getSemiBoldStyle({
  double? fontSize,
  double? height,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? FontSize.s13,
      FontWeightManager.semiBold,
      height,
      color,
    );

TextStyle getBoldStyle({
  double? fontSize,
  double? height,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? FontSize.s13,
      FontWeightManager.bold,
      height,
      color,
    );

TextStyle getTextWithLine() => TextStyle(
      color: ColorManager.black,
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: ColorManager.black,
      fontFamily: 'DMSans',
    );

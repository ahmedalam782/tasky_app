import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  Widget? leading,
  TextStyle? style,
}) {
  return AppBar(
    leading: leading,
    title: Text(
      title,
      style: style ??
          getBoldStyle(
            color: ColorManager.mainBlack,
            fontSize: FontSize.s16,
          ),
    ),
  );
}

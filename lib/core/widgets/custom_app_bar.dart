import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  TextStyle? style,
  bool automaticallyImplyLeading = true,
  void Function()? onTap,
  List<Widget>? actions,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: automaticallyImplyLeading
        ? Padding(
            padding: EdgeInsetsDirectional.only(
                start: Insets.s22.w, top: Insets.s12.h, bottom: Insets.s12.h),
            child: InkWell(
              onTap: onTap,
              child: SvgPicture.asset(
                SvgAssets.assetsSvgArrowLeftBlack,
              ),
            ),
          )
        : null,
    title: Text(
      title,
      style: style ??
          getBoldStyle(
            color: ColorManager.mainBlack,
            fontSize: FontSize.s16,
          ),
    ),
    actions: actions ?? [],
  );
}

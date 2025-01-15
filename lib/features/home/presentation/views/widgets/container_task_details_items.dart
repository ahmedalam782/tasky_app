import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';

class ContainerTaskDetailsItems extends StatelessWidget {
  const ContainerTaskDetailsItems({
    super.key,
    this.color,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.subtitle,
  });
  final Color? color;
  final String? title;
  final String? subtitle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Insets.s24.w, vertical: Insets.s16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: color ?? ColorManager.titanWhite,
      ),
      child: Row(
        spacing: prefixIcon == null ? 0 : 10.w,
        children: [
          prefixIcon ?? const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              subtitle != null
                  ? Text(
                      subtitle ?? '',
                      style: style ??
                          getRegularStyle(
                            color: ColorManager.grey3,
                            fontSize: FontSize.s9,
                          ),
                    )
                  : SizedBox(),
              Text(
                title ?? '',
                style: style ??
                    getRegularStyle(
                      color: ColorManager.mainBlack,
                      fontSize: FontSize.s14,
                    ),
              ),
            ],
          ),
          Spacer(),
          suffixIcon ?? const SizedBox(),
        ],
      ),
    );
  }
}

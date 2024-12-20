import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class CustomButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final Color? backgroundColor;
  final double? radius;
  final void Function() onTap;
  final TextStyle? textStyle;
  final bool isStadiumBorder;

  const CustomButton({
    super.key,
    this.prefixIcon,
    this.textStyle,
    this.isStadiumBorder = false,
    this.backgroundColor,
    this.radius,
    this.suffixIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: isStadiumBorder
            ? const StadiumBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
        backgroundColor: backgroundColor ?? ColorManager.primary,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(double.infinity, 49.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon ?? const SizedBox(),
          prefixIcon != null
              ? SizedBox(
                  width: 8.w,
                )
              : const SizedBox(),
          Text(
            label,
            style: textStyle ??
                getBoldStyle(color: ColorManager.white)
                    .copyWith(fontSize: FontSize.s16),
          ),
          suffixIcon != null
              ? SizedBox(
                  width: 8.w,
                )
              : const SizedBox(),
          suffixIcon ?? const SizedBox(),
        ],
      ),
    );
  }
}

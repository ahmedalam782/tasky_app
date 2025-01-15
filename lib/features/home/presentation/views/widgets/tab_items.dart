import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';

class TabItems extends StatelessWidget {
  const TabItems({
    super.key,
    required this.title,
    required this.isSelected,
  });

  final Enum title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          EdgeInsets.symmetric(horizontal: Insets.s12.w, vertical: Insets.s8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: isSelected ? ColorManager.primary : ColorManager.titanWhite,
      ),
      child: Text(
        title.name.toUpperCase(),
        style: isSelected
            ? getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16)
            : getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.mediumGrey,
              ),
      ),
    );
  }
}

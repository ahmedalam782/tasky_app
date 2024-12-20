import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/widgets/custom_button.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/routes/routes.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            height: 482.h,
            width: 375.w,
            fit: Platform.isWindows ? BoxFit.contain : BoxFit.fill,
            ImageAssets.assetsOnBoarding,
          ),
        ),
        Positioned(
          bottom: 70.h,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              spacing: 8,
              children: [
                SizedBox(
                  width: 235.w,
                  child: Text(
                    AppConstants.taskManagementTitle,
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        color: ColorManager.mainBlack, fontSize: FontSize.s24),
                  ),
                ),
                SizedBox(
                  width: 255.w,
                  child: Text(
                    AppConstants.taskManagementDescription,
                    textAlign: TextAlign.center,
                    textHeightBehavior: const TextHeightBehavior(
                        applyHeightToLastDescent: true),
                    style: getRegularStyle(
                        color: ColorManager.grey3,
                        fontSize: FontSize.s14,
                        height: 1.8),
                  ),
                ),
                CustomButton(
                  label: AppConstants.letsStart,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                  suffixIcon: SvgPicture.asset(
                    width: 24.w,
                    height: 24.h,
                    SvgAssets.assetsSvgArrowLeft,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

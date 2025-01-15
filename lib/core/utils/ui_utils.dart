import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/widgets/custom_button.dart';
import 'package:tasky_app/core/widgets/loading_indicator.dart';

class UiUtils {
  static void showLoadingDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
              backgroundColor: ColorManager.white,
              content: SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .01,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingIndicator(),
                  ],
                ),
              )),
        ),
      );

  static void showConnectionDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(
              "Connection Problem",
              style: getBoldStyle(
                  color: ColorManager.mainBlack, fontSize: FontSize.s24),
            ),
            backgroundColor: ColorManager.white,
            content: Text(
              "Something went wrong.\nplease check your internet connection and try again.",
              style: getSemiBoldStyle(
                  color: ColorManager.mainBlack, fontSize: FontSize.s13),
            ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: getBoldStyle(
                      color: ColorManager.primary, fontSize: FontSize.s16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );

  static void hideLoadingDialog(BuildContext context) => Navigator.pop(context);
  static void showMessageToast(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.white,
        textColor: ColorManager.mainBlack,
        fontSize: FontSize.s16,
      );

  static Color changeContainerColor(String type) {
    if (type.toLowerCase() == "Waiting".toLowerCase() ||
        type.toLowerCase() == "High".toLowerCase()) {
      return ColorManager.amour;
    } else if (type.toLowerCase() == "InProgress".toLowerCase() ||
        type.toLowerCase() == "Medium".toLowerCase()) {
      return ColorManager.titanWhite;
    } else {
      return ColorManager.pattensBlue;
    }
  }

  static Color changeTextColor(String type) {
    if (type.toLowerCase() == "waiting".toLowerCase() ||
        type.toLowerCase() == "high".toLowerCase()) {
      return ColorManager.orange;
    } else if (type.toLowerCase() == "inProgress".toLowerCase() ||
        type.toLowerCase() == "medium".toLowerCase()) {
      return ColorManager.primary;
    } else {
      return ColorManager.blue;
    }
  }

  static Widget changeArrowDrop(String type) {
    if (type.toLowerCase() == "high".toLowerCase() ||
        type.toLowerCase() == "waiting".toLowerCase()) {
      return SvgPicture.asset(SvgAssets.assetsSvgArrowDownOrange,
          width: 24.w, height: 24.h);
    } else if (type.toLowerCase() == "medium".toLowerCase() ||
        type.toLowerCase() == "inProgress".toLowerCase()) {
      return SvgPicture.asset(SvgAssets.assetsSvgArrowDownPurple,
          width: 24.w, height: 24.h);
    } else {
      return SvgPicture.asset(SvgAssets.assetsSvgArrowDownBlue,
          width: 24.w, height: 24.h);
    }
  }

  static Widget changeFlagPriority(String type) {
    if (type.toLowerCase() == "high".toLowerCase()) {
      return SvgPicture.asset(SvgAssets.assetsSvgFlagOrange,
          width: 24.w, height: 24.h);
    } else if (type.toLowerCase() == "medium".toLowerCase()) {
      return SvgPicture.asset(SvgAssets.assetsSvgFlagPurple,
          width: 24.w, height: 24.h);
    } else {
      return SvgPicture.asset(SvgAssets.assetsSvgFlagBlue,
          width: 24.w, height: 24.h);
    }
  }

  static String convertTimestampToDate(
    DateTime? createdAt, [
    String newPattern = 'dd/MM/yyyy',
  ]) {
    if (createdAt == null) {
      return '';
    } else {
      DateFormat dateFormat = DateFormat(newPattern);
      String formattedDate = dateFormat.format(createdAt);
      return formattedDate;
    }
  }

  static void showAlertDialog(BuildContext context,
          {required String message, required void Function() onTapYes}) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: ColorManager.white,
            content: SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width * .01,
              child: Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: getSemiBoldStyle(
                    color: ColorManager.mainBlack,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                spacing: 8.w,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    label: 'No',
                    minimumSize: Size(110.w, 49.h),
                    onTap: () => Navigator.pop(context),
                  ),
                  CustomButton(
                    minimumSize: Size(110.w, 49.h),
                    label: 'Yes',
                    onTap: onTapYes,
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

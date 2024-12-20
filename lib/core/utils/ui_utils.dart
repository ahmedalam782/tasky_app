import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
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
}

import 'package:flutter/material.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * .09),
        child: Text(
          message ?? " SomeThing went Wrong!",
          style: getMediumStyle(
              color: ColorManager.mainBlack, fontSize: FontSize.s14),
        ),
      ),
    );
  }
}

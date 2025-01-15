import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        height: height ?? 150.h,
        JsonAssets.assetsJsonLoading,
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/widgets/custom_button.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_states.dart';
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
                BlocListener<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    if (state is AccessTokenLoading) {
                    } else if (state is AccessTokenSuccess) {
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    } else if (state is AccessTokenError) {
                      Navigator.of(context).pushReplacementNamed(Routes.login);
                    }
                  },
                  child: CustomButton(
                    label: AppConstants.letsStart,
                    onTap: () {
                      Future.delayed(const Duration(microseconds: 0), () async {
                        if (await _checkConnection() == false) {
                          if (!mounted) return;
                          // ignore: use_build_context_synchronously
                          UiUtils.showConnectionDialog(context);
                        } else {
                          // _authCubit.getRefreshToken();
                          // _authCubit.getNewAccessToken();
                        }
                      });
                    },
                    suffixIcon: SvgPicture.asset(
                      width: 24.w,
                      height: 24.h,
                      SvgAssets.assetsSvgArrowLeft,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _checkConnection() async {
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }
}

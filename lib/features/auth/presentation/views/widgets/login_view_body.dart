import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/utils/validator.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_states.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/phone_text_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _fullPhoneNumber;
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isLargeScreen = constraints.maxWidth > 1000;
      AuthCubit cubit = AuthCubit.get(context);

      return Stack(
        alignment: Alignment.bottomCenter,
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isLargeScreen ? 300.w : 25.w, vertical: 30.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.44),
                  Text(
                    AppConstants.login,
                    textAlign: TextAlign.center,
                    textHeightBehavior: const TextHeightBehavior(
                        applyHeightToLastDescent: true),
                    style: getBoldStyle(
                      color: ColorManager.mainBlack,
                      fontSize: FontSize.s24,
                    ),
                  ),
                  PhoneTextField(
                    phoneController: _phoneController,
                    validator: Validator.validatePhoneNumber,
                    onChanged: (phoneNumber) {
                      _fullPhoneNumber = phoneNumber;
                    },
                  ),
                  CustomTextFormField(
                    hint: AppConstants.password,
                    controller: _passwordController,
                    validation: Validator.validatePassword,
                    isObscured: true,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BlocListener<AuthCubit, AuthStates>(
                    listener: (_, state) {
                      if (state is LoginLoadingStates) {
                        UiUtils.showLoadingDialog(context);
                      } else if (state is LoginErrorStates) {
                        UiUtils.hideLoadingDialog(context);
                        UiUtils.showMessageToast(state.error);
                      } else if (state is LoginSuccessStates) {
                        UiUtils.hideLoadingDialog(context);
                        Navigator.pushReplacementNamed(context, Routes.home);
                      }
                    },
                    child: CustomButton(
                        label: AppConstants.signIn,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.login(
                              LoginRequest(
                                phone: _fullPhoneNumber!,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        }),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Center(
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppConstants.didNotHaveAccount,
                            style: getRegularStyle(
                              color: ColorManager.darkGrey1,
                              fontSize: FontSize.s14,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: AppConstants.signUpHere,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.register);
                              },
                            style: getBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s14,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

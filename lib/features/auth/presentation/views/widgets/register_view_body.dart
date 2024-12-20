import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/utils/validator.dart';
import 'package:tasky_app/core/widgets/custom_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/core/widgets/default_drop_btn.dart';
import 'package:tasky_app/core/widgets/phone_text_field.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_states.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _experienceYearsController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final List<String> _experienceLevelsDisplay = [
    'Fresh',
    'Junior',
    'Mid level',
    'Senior',
  ];
  Map<String, String> experienceLevelMapping = {
    'Junior': 'junior',
    'Mid level': 'midLevel',
    'Senior': 'senior',
    'Fresh': 'fresh',
  };
  String? _currentValue;
  String? _fullPhoneNumber;
  String? _experienceLevel;
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _experienceYearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      context,
      constraints,
    ) {
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
                spacing: 15.h,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.32),
                  Text(
                    AppConstants.signUp,
                    textAlign: TextAlign.center,
                    textHeightBehavior: const TextHeightBehavior(
                        applyHeightToLastDescent: true),
                    style: getBoldStyle(
                      color: ColorManager.mainBlack,
                      fontSize: FontSize.s24,
                    ),
                  ),
                  CustomTextFormField(
                    hint: AppConstants.name,
                    controller: _nameController,
                    validation: Validator.validateName,
                  ),
                  PhoneTextField(
                    phoneController: _phoneController,
                    validator: Validator.validatePhoneNumber,
                    onChanged: (phoneNumber) {
                      _fullPhoneNumber = phoneNumber;
                    },
                  ),
                  CustomTextFormField(
                    hint: AppConstants.yearsOfExperience,
                    controller: _experienceYearsController,
                    validation: Validator.validateYearsOfExperience,
                    textInputType: TextInputType.number,
                  ),
                  DefaultDropBtn(
                    hint: AppConstants.chooseExperienceLevel,
                    currentValue: _currentValue,
                    alignment: AlignmentDirectional.centerStart,
                    validator: Validator.validateLevelOfExperience,
                    onChanged: (value) {
                      _currentValue = value!;
                      _experienceLevel = experienceLevelMapping[value];
                      setState(() {});
                    },
                    items: _experienceLevelsDisplay
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: getMediumStyle(
                                    color: ColorManager.black1,
                                    fontSize: FontSize.s14),
                              ),
                            ))
                        .toList(),
                  ),
                  CustomTextFormField(
                    hint: AppConstants.address,
                    controller: _addressController,
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
                      if (state is RegisterLoadingStates) {
                        UiUtils.showLoadingDialog(context);
                      } else if (state is RegisterErrorStates) {
                        UiUtils.hideLoadingDialog(context);
                        UiUtils.showMessageToast(state.error);
                      } else if (state is RegisterSuccessStates) {
                        UiUtils.hideLoadingDialog(context);
                        Navigator.pushReplacementNamed(context, Routes.home);
                      }
                    },
                    child: CustomButton(
                      label: AppConstants.signUp,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.register(RegisterRequest(
                            name: _nameController.text,
                            phone: _fullPhoneNumber!,
                            yearOfExperience:
                                int.parse(_experienceYearsController.text),
                            experienceLevel: _experienceLevel!,
                            password: _passwordController.text,
                            address: _addressController.text,
                          ));
                        }
                      },
                    ),
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
                            text: AppConstants.alreadyHaveAccount,
                            style: getRegularStyle(
                              color: ColorManager.darkGrey1,
                              fontSize: FontSize.s14,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: AppConstants.signIn,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.login);
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

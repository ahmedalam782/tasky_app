import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
    this.onChanged,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding: const EdgeInsets.only(top: Insets.s8),
                child: Text(
                  widget.label!,
                  style: widget.labelTextStyle ??
                      getMediumStyle(color: ColorManager.white)
                          .copyWith(fontSize: FontSize.s13),
                ),
              )
            : const SizedBox(),
        Container(
          margin: EdgeInsets.only(top: Insets.s8.h),
          decoration: ShapeDecoration(
            color: widget.backgroundColor ?? ColorManager.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: widget.borderBackgroundColor ?? ColorManager.darkGrey1,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: getBoldStyle(color: ColorManager.mainBlack)
                .copyWith(fontSize: FontSize.s18),
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? ColorManager.primary,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validation!(value));
              }
              return errorText;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(Insets.s13.sp),
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s16),
                      child: IconButton(
                        onPressed: () => setState(() => hidden = !hidden),
                        iconSize: Sizes.s24,
                        splashRadius: Sizes.s10,
                        isSelected: !hidden,
                        color: widget.cursorColor,
                        selectedIcon: Icon(
                          Icons.visibility_off_outlined,
                          color: ColorManager.darkGrey1,
                        ),
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: ColorManager.darkGrey1,
                        ),
                      ),
                    )
                  : widget.suffixIcon,
              hintStyle: widget.hintTextStyle ??
                  getRegularStyle(color: ColorManager.grey)
                      .copyWith(fontSize: FontSize.s14),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: ColorManager.primary,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: InputBorder.none,
              errorStyle: TextStyle(
                fontSize: FontSize.s0,
                color: ColorManager.transparent,
              ),
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: EdgeInsetsDirectional.only(
                  top: Insets.s8.h,
                  start: Insets.s8.w,
                ),
                child: Text(
                  errorText!,
                  style: getRegularStyle(color: ColorManager.red)
                      .copyWith(fontSize: 13.sp),
                ),
              ),
      ],
    );
  }
}

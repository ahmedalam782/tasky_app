import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';

class DefaultDropBtn extends StatefulWidget {
  const DefaultDropBtn({
    super.key,
    required this.currentValue,
    this.onChanged,
    this.labelTextStyle,
    this.label,
    required this.items,
    this.borderRadius,
    this.alignment,
    this.isExpanded = true,
    this.isDense = true,
    this.decoration,
    this.hint = '',
    this.validator,
  });

  final String? currentValue;

  final void Function(String?)? onChanged;
  final TextStyle? labelTextStyle;
  final String? label;
  final String hint;
  final List<DropdownMenuItem<String>>? items;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;
  final InputDecoration? decoration;
  final bool isExpanded;
  final bool isDense;
  final String? Function(String?)? validator;

  @override
  State<DefaultDropBtn> createState() => _DefaultDropBtnState();
}

class _DefaultDropBtnState extends State<DefaultDropBtn> {
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style: widget.labelTextStyle ??
                    getBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
              )
            : const SizedBox(),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            style: getBoldStyle(
              color: ColorManager.black1,
              fontSize: FontSize.s14,
            ),
            alignment: widget.alignment ?? Alignment.center,
            decoration: widget.decoration ??
                InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: ColorManager.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: ColorManager.darkGrey1,
                    ),
                  ),
                  errorStyle: TextStyle(
                    fontSize: FontSize.s0,
                    color: ColorManager.transparent,
                  ),
                ),
            items: widget.items,
            onChanged: widget.onChanged,
            validator: (value) {
              if (widget.validator == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validator!(value));
              }
              return errorText;
            },
            dropdownColor: ColorManager.white,
            isDense: widget.isDense,
            iconSize: 24,
            isExpanded: widget.isExpanded,
            hint: Text(widget.hint,
                style: getMediumStyle(
                  color: ColorManager.black1,
                  fontSize: FontSize.s14,
                )),
            icon: Icon(
              MdiIcons.chevronDown,
              size: 24,
              color: ColorManager.darkGrey1, // Add this
            ),
            value: widget.currentValue,
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

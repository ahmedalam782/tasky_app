import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';

import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.phoneController,
    this.validator,
    this.onChanged,
  });

  final TextEditingController phoneController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  String _selectedCountryCode = '20';

  String _selectedCountryFlag = 'eg';

  void _updatePhoneNumber(String phoneNumber) {
    final fullPhoneNumber = '+$_selectedCountryCode$phoneNumber';
    widget.onChanged?.call(fullPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.phoneController,
      hint: '123 456-7890',
      prefixIcon: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (country) {
              setState(() {
                _selectedCountryCode = country.phoneCode;
                _selectedCountryFlag = country.countryCode;

                _updatePhoneNumber(widget.phoneController.text);
              });
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CountryFlag.fromCountryCode(
                  shape: RoundedRectangle(7.r),
                  height: 24,
                  width: 24,
                  _selectedCountryFlag.toLowerCase()),
              SizedBox(
                width: 5.w,
              ),
              Text(
                '+$_selectedCountryCode',
                style: getBoldStyle(
                    color: ColorManager.grey3, fontSize: FontSize.s14),
              ),
              Icon(
                MdiIcons.chevronDown,
                size: 25,
                color: ColorManager.darkGrey2,
              ),
            ],
          ),
        ),
      ),
      textInputType: TextInputType.phone,
      validation: widget.validator,
      onChanged: (value) {
        _updatePhoneNumber(value);
      },
    );
  }
}

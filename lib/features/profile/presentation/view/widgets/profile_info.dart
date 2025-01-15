import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/features/profile/domain/entities/profile_info_entity.dart';

class ProfileInfoContainer extends StatelessWidget {
  const ProfileInfoContainer({
    super.key,
    required this.profileInfo,
  });
  final ProfileInfoEntity profileInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: ColorManager.whiteSmoke),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileInfo.title,
                style: getMediumStyle(
                  color: ColorManager.blackThunder.withValues(alpha: .4),
                  fontSize: FontSize.s12,
                ),
              ),
              Text(
                profileInfo.value,
                style: getBoldStyle(
                  color: ColorManager.blackThunder.withValues(alpha: .6),
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
          Spacer(),
          Visibility(
            visible: profileInfo.isVisibleCopyButton,
            child: GestureDetector(
              onTap: () => _copyData(profileInfo.value, context),
              child: SvgPicture.asset(
                SvgAssets.assetsSvgCopy,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyData(phoneNumber, context) async {
    await Clipboard.setData(ClipboardData(text: phoneNumber));
    UiUtils.showMessageToast(AppConstants.copyToClipboard);
  }
}

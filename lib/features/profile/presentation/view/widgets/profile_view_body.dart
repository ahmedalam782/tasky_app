import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/widgets/loading_indicator.dart';
import 'package:tasky_app/features/profile/domain/entities/profile_info_entity.dart';
import 'package:tasky_app/features/profile/presentation/view/widgets/profile_info.dart';
import 'package:tasky_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:tasky_app/features/profile/presentation/view_model/cubit/profile_states.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is GetProfileLoading) {
          return LoadingIndicator();
        }
        if (state is GetProfileError) {
          ProfileCubit.get(context).getProfile();
          return Center(
            child: Text(
              state.message,
              style: getRegularStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s24,
              ),
            ),
          );
        }

        if (state is GetProfileSuccess) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.s24.w),
            child: Column(
              spacing: 8.h,
              children: [
                SizedBox(height: 24.h),
                ProfileInfoContainer(
                  profileInfo: ProfileInfoEntity(
                      title: AppConstants.nameProfile.toUpperCase(),
                      value: state.profileEntity.displayName ?? 'N/A'),
                ),
                ProfileInfoContainer(
                  profileInfo: ProfileInfoEntity(
                    title: AppConstants.phone.toUpperCase(),
                    value: state.profileEntity.username ?? 'N/A',
                    isVisibleCopyButton: true,
                  ),
                ),
                ProfileInfoContainer(
                  profileInfo: ProfileInfoEntity(
                      title: AppConstants.level.toUpperCase(),
                      value: state.profileEntity.level ?? 'N/A'),
                ),
                ProfileInfoContainer(
                  profileInfo: ProfileInfoEntity(
                    title: AppConstants.yearsOfExperienceProfile.toUpperCase(),
                    value: state.profileEntity.experienceYears == null
                        ? 'N/A'
                        : "${state.profileEntity.experienceYears.toString()} years",
                  ),
                ),
                ProfileInfoContainer(
                  profileInfo: ProfileInfoEntity(
                      title: AppConstants.location.toUpperCase(),
                      value: state.profileEntity.address ?? 'N/A'),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              "Failed to get profile data",
              style: getRegularStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s24,
              ),
            ),
          );
        }
      },
    );
  }
}

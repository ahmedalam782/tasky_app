import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/features/profile/presentation/view/widgets/profile_view_body.dart';
import 'package:tasky_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator.get<ProfileCubit>()..getProfile(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          onTap: () {
            Navigator.pop(context);
          },
          title: AppConstants.profile,
          automaticallyImplyLeading: true,
        ),
        body: ProfileViewBody(),
      ),
    );
  }
}

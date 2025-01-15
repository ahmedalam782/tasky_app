import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_states.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_cubit.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/floating_action_button_items.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator.get<HomeCubit>()..getTasks(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: buildAppBar(context,
              title: AppConstants.logo,
              automaticallyImplyLeading: false,
              style: getBoldStyle(
                color: ColorManager.mainBlack,
                fontSize: FontSize.s24,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    AuthCubit.get(context).getNewAccessToken();
                    Navigator.of(context).pushNamed(Routes.profile);
                  },
                  icon: Icon(
                    size: 24.w,
                    MdiIcons.accountCircleOutline,
                    color: ColorManager.black,
                  ),
                ),
                BlocListener<AuthCubit, AuthStates>(
                  listener: (_, state) {
                    if (state is LogOutLoading) {
                      UiUtils.showLoadingDialog(context);
                    } else if (state is LogOutSuccess) {
                      UiUtils.hideLoadingDialog(context);
                      Navigator.of(context).pushReplacementNamed(Routes.login);
                      UiUtils.showMessageToast('Log out successfully');
                      AuthCubit.get(context).saveAccessToken("");
                      AuthCubit.get(context).saveRefreshToken("");
                    } else if (state is LogOutError) {
                      UiUtils.hideLoadingDialog(context);
                      UiUtils.showMessageToast(
                          "Log out failed ${state.message}");
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      AuthCubit.get(context).logOut();
                    },
                    icon: Icon(
                      size: 24.w,
                      Icons.logout,
                      color: ColorManager.primary,
                    ),
                  ),
                )
              ]),
          body: HomeViewBody(),
          floatingActionButton: FloatingActionButtonItems(),
        ),
      ),
    );
  }
}

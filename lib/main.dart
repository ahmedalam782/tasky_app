import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/utils/bloc_observer.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'core/Themes/app_theme.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorManager.white,
    statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
    statusBarIconBrightness:
        Platform.isIOS ? Brightness.light : Brightness.dark,
    // Dark text for status bar
  ));

  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await configureDependencies();
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    double designWidth =
        Platform.isWindows ? MediaQuery.of(context).size.width : 375;
    double designHeight =
        Platform.isWindows ? MediaQuery.of(context).size.height : 812;
    return DevicePreview(
        enabled: true,
        builder: (context) {
          return ScreenUtilInit(
            designSize: Size(designWidth, designHeight),
            minTextAdapt: false,
            splitScreenMode: true,
            builder: (context, child) => BlocProvider(
              create: (_) => serviceLocator.get<AuthCubit>(),
              child: MaterialApp(
                onGenerateRoute: RouteGenerator.getRoute,
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.onBoarding,
                themeMode: ThemeMode.light,
                theme: AppTheme.lightTheme,
              ),
            ),
          );
        });
  }
}

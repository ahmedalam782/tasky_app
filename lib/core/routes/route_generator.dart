import 'package:flutter/material.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/features/auth/presentation/views/screen/register_screen.dart';
import 'package:tasky_app/features/home/presentation/views/screens/barcode_screen.dart';
import 'package:tasky_app/features/home/presentation/views/screens/home_screen.dart';
import 'package:tasky_app/features/home/presentation/views/screens/task_details_screen.dart';
import 'package:tasky_app/features/profile/presentation/view/screens/profile_screens.dart';
import 'package:tasky_app/features/tasks/presentation/view/screens/tasks_screen.dart';

import '../../features/auth/presentation/views/screen/login_screen.dart';
import '../../features/on_boarding/presentation/views/screens/on_boarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.taskDetails:
        return MaterialPageRoute(
          builder: (_) => const TaskDetailsScreen(),
          settings: settings,
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreens(),
        );
      case Routes.addTask:
        return MaterialPageRoute(
          builder: (_) => const TasksScreen(),
          settings: settings,
        );
      case Routes.scanBarcode:
        return MaterialPageRoute(
            builder: (_) => const BarcodeScreen(), settings: settings);
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}

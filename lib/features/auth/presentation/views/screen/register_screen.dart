import 'package:flutter/material.dart';

import 'package:tasky_app/features/auth/presentation/views/widgets/register_view_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: RegisterViewBody(),
          ),
        ),
      ),
    );
  }
}

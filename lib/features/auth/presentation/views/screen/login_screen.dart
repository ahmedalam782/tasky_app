import 'package:flutter/material.dart';

import '../widgets/login_view_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: LoginViewBody(),
        )),
      ),
    );
  }
}

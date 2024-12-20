import 'package:flutter/material.dart';

import '../widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(child: OnBoardingViewBody()),
      ),
    );
  }
}

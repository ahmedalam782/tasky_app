import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_cubit.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/barcode_view_body.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator.get<HomeCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.black,
        appBar: buildAppBar(
          context,
          onTap: () => Navigator.pop(context),
          title: AppConstants.scanBarcode,
          automaticallyImplyLeading: true,
        ),
        body: BarcodeViewBody(),
      ),
    );
  }
}

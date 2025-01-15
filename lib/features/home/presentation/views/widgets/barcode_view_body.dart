import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_cubit.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_state.dart';

class BarcodeViewBody extends StatefulWidget {
  const BarcodeViewBody({super.key});

  @override
  State<BarcodeViewBody> createState() => _BarcodeViewBodyState();
}

class _BarcodeViewBodyState extends State<BarcodeViewBody> {
  Barcode? _barcode;
  MobileScannerController? _cameraController;
  @override
  void initState() {
    super.initState();

    _cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
      _cameraController?.stop();
      await HomeCubit.get(context).getTaskById(_barcode?.displayValue ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetTaskByIdLoading) {
              UiUtils.showLoadingDialog(context);
            } else if (state is GetTaskByIdError) {
              UiUtils.hideLoadingDialog(context);
              UiUtils.showMessageToast(state.message);
            } else if (state is GetTaskByIdSuccess) {
              UiUtils.hideLoadingDialog(context);
              Navigator.pushReplacementNamed(context, Routes.taskDetails,
                  arguments: state.task);
            }
          },
          child: MobileScanner(
            controller: _cameraController,
            onDetect: _handleBarcode,
          ),
        ),
      ],
    );
  }
}

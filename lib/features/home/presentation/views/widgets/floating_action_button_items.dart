import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';

class FloatingActionButtonItems extends StatelessWidget {
  const FloatingActionButtonItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14.h,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.w,
          child: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () => Navigator.pushNamed(context, Routes.scanBarcode),
            tooltip: 'Add',
            heroTag: 'Barcode',
            child: SvgPicture.asset(
              height: 24.h,
              width: 24.w,
              SvgAssets.assetsSvgBarcodeIcon,
            ),
          ),
        ),
        SizedBox(
          height: 64.h,
          width: 64.w,
          child: FloatingActionButton(
            tooltip: 'Add',
            heroTag: 'Task',
            shape: CircleBorder(),
            backgroundColor: ColorManager.primary,
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.addTask,
              arguments: TaskEntity(),
            ),
            child: Icon(
              color: ColorManager.white,
              Icons.add,
              size: 32,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_cubit.dart';

void showBottomSheetAddImage(context) => showModalBottomSheet(
      backgroundColor: ColorManager.white,
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: ColorManager.primary),
              title: Text(
                'Camera',
                style: getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s16,
                ),
              ),
              onTap: () => _uploadImage(context, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: ColorManager.primary),
              title: Text(
                'Gallery',
                style: getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s16,
                ),
              ),
              onTap: () => _uploadImage(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
Future<void> _uploadImage(context, ImageSource source) async {
  await AuthCubit.get(context).getNewAccessToken();
  await TasksCubit.get(context).uploadImage(source);
}

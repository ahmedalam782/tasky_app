import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_cubit.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_states.dart';

class PopupMenuItems extends StatefulWidget {
  const PopupMenuItems({super.key, required this.task});
  final TaskEntity task;
  @override
  State<PopupMenuItems> createState() => _PopupMenuItemsState();
}

class _PopupMenuItemsState extends State<PopupMenuItems> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksCubit, TasksStates>(
      listener: (context, state) {
        if (state is DeleteTaskLoading) {
          UiUtils.showLoadingDialog(context);
        } else if (state is DeleteTaskSuccess) {
          UiUtils.hideLoadingDialog(context);
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is DeleteTaskError) {
          UiUtils.hideLoadingDialog(context);
          UiUtils.showMessageToast(state.message);
        }
      },
      child: PopupMenuButton<String>(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        offset: Offset(-30.w, 30.h),
        menuPadding: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: Insets.s22.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: ColorManager.white,
          ),
        ),
        // position: PopupMenuPosition.under,
        color: ColorManager.white,
        onOpened: () => setState(() {
          isOpened = true;
        }),
        onCanceled: () => setState(() {
          isOpened = false;
        }),
        onSelected: (value) {
          if (value == AppConstants.edit) {
            Navigator.pushNamed(context, Routes.addTask,
                arguments: widget.task);
          } else if (value == AppConstants.delete) {
            UiUtils.showAlertDialog(context,
                message: AppConstants.deleteMessage, onTapYes: () async {
              AuthCubit.get(context).getNewAccessToken();
              await TasksCubit.get(context).deleteTask(widget.task.id!);
            });
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: AppConstants.edit,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
              child: Text(
                AppConstants.edit,
                textAlign: TextAlign.start,
                style: getMediumStyle(
                    color: ColorManager.black, fontSize: FontSize.s16),
              ),
            ),
          ),
          PopupMenuDivider(
            height: 1,
          ),
          PopupMenuItem<String>(
            value: AppConstants.delete,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
              child: Text(
                AppConstants.delete,
                textAlign: TextAlign.start,
                style: getMediumStyle(
                  color: ColorManager.orange,
                  fontSize: FontSize.s16,
                ), // Set delete text to orange
              ),
            ),
          ),
        ],
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Visibility(
              visible: isOpened,
              child: Positioned(
                  top: 20.h,
                  right: 35.w,
                  child: SvgPicture.asset(
                    fit: BoxFit.fill,
                    SvgAssets.assetsSvgMenuTop,
                    height: 10.h,
                    width: 41.24.w,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.s22.w),
              child: Icon(
                Icons.more_vert,
                color: ColorManager.black,
                size: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/widgets/loading_indicator.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/container_task_details_items.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TaskDetailsViewBody extends StatefulWidget {
  const TaskDetailsViewBody({super.key});

  @override
  State<TaskDetailsViewBody> createState() => _TaskDetailsViewBodyState();
}

class _TaskDetailsViewBodyState extends State<TaskDetailsViewBody> {
  bool isImage = false;
  @override
  Widget build(BuildContext context) {
    TaskEntity taskEntity =
        ModalRoute.of(context)!.settings.arguments as TaskEntity;
    isImage = taskEntity.image == null
        ? false
        : Uri.parse(taskEntity.image!).hasAbsolutePath;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          isImage
              ? taskEntity.image == null
                  ? Center(
                      child: Image.asset(
                        height: 225.h,
                        ImageAssets.assetsImageError,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Center(
                      child: CachedNetworkImage(
                        imageUrl: taskEntity.image!,
                        height: 225.h,
                        width: double.infinity,
                        placeholder: (context, url) => const LoadingIndicator(),
                        errorWidget: (_, __, ___) => Center(
                          child: Image.asset(
                            height: 225.h,
                            ImageAssets.assetsImageError,
                            fit: BoxFit.fill,
                          ),
                        ),
                        fit: BoxFit.fill,
                      ),
                    )
              : Center(
                  child: Image.asset(
                    height: 225.h,
                    ImageAssets.assetsImageError,
                    fit: BoxFit.fill,
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.s22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  taskEntity.title ?? "",
                  style: getBoldStyle(
                      color: ColorManager.mainBlack, fontSize: FontSize.s24),
                ),
                Text(
                  taskEntity.desc ?? "",
                  style: getRegularStyle(
                      color: ColorManager.darkGrey1,
                      fontSize: FontSize.s14,
                      height: 3.h,
                      letterSpacing: 2),
                ),
                ContainerTaskDetailsItems(
                  subtitle: AppConstants.createdAt,
                  title: UiUtils.convertTimestampToDate(
                      taskEntity.createdAt, 'dd,MMMM,yyyy'),
                  suffixIcon: SvgPicture.asset(
                    SvgAssets.assetsSvgCalendar,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                ContainerTaskDetailsItems(
                  color: UiUtils.changeContainerColor(taskEntity.status ?? ''),
                  title: taskEntity.status ?? "",
                  style: getBoldStyle(
                      color: UiUtils.changeTextColor(taskEntity.status ?? ''),
                      fontSize: FontSize.s16),
                  suffixIcon: UiUtils.changeArrowDrop(taskEntity.status ?? ''),
                ),
                ContainerTaskDetailsItems(
                  color:
                      UiUtils.changeContainerColor(taskEntity.priority ?? ''),
                  prefixIcon:
                      UiUtils.changeFlagPriority(taskEntity.priority ?? ''),
                  title: "${taskEntity.priority} ${AppConstants.priority}",
                  style: getBoldStyle(
                      color: UiUtils.changeTextColor(taskEntity.priority ?? ''),
                      fontSize: FontSize.s16),
                  suffixIcon:
                      UiUtils.changeArrowDrop(taskEntity.priority ?? ''),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: SizedBox(
                    height: 326.h,
                    width: 326.w,
                    child: Center(
                      child: PrettyQrView.data(
                        data: taskEntity.id ?? "",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

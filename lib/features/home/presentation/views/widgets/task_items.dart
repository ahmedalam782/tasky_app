import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/widgets/loading_indicator.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';

class TaskItems extends StatefulWidget {
  const TaskItems({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  State<TaskItems> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItems> {
  bool isImage = false;

  @override
  Widget build(BuildContext context) {
    isImage = widget.taskEntity.image == null
        ? false
        : Uri.parse(widget.taskEntity.image!).hasAbsolutePath;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.taskDetails,
          arguments: widget.taskEntity,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Insets.s12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.w,
          children: [
            isImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(63.37.r),
                    child: widget.taskEntity.image == null
                        ? Center(
                            child: Image.asset(
                              height: 64.h,
                              width: 64.w,
                              ImageAssets.assetsImageError,
                              fit: BoxFit.fill,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.taskEntity.image!,
                            height: 64.h,
                            width: 64.w,
                            placeholder: (context, url) =>
                                const LoadingIndicator(),
                            errorWidget: (_, __, ___) => Center(
                              child: Image.asset(
                                height: 64.h,
                                ImageAssets.assetsImageError,
                                fit: BoxFit.fill,
                              ),
                            ),
                            fit: BoxFit.fill,
                          ),
                  )
                : Center(
                    child: Image.asset(
                      height: 64.h,
                      width: 64.w,
                      ImageAssets.assetsImageError,
                      fit: BoxFit.fill,
                    ),
                  ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      Expanded(
                        child: Text(
                          widget.taskEntity.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getBoldStyle(
                              color: ColorManager.mainBlack,
                              fontSize: FontSize.s16),
                        ),
                      ),
                      widget.taskEntity.status == null ||
                              widget.taskEntity.status == ""
                          ? const SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.s6.w,
                                vertical: Insets.s2.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: UiUtils.changeContainerColor(
                                    widget.taskEntity.status ?? ""),
                              ),
                              child: Text(
                                widget.taskEntity.status == null
                                    ? ""
                                    : widget.taskEntity.status!,
                                style: getMediumStyle(
                                  color: UiUtils.changeTextColor(
                                      widget.taskEntity.status ?? ""),
                                  fontSize: FontSize.s12,
                                ),
                              ),
                            ),
                    ],
                  ),
                  Text(
                    widget.taskEntity.desc ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(
                      color: ColorManager.darkGrey1,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      UiUtils.changeFlagPriority(
                          widget.taskEntity.priority ?? ""),
                      Text(
                        widget.taskEntity.priority ?? "",
                        style: getMediumStyle(
                          color: UiUtils.changeTextColor(
                              widget.taskEntity.priority ?? ""),
                          fontSize: FontSize.s12,
                        ),
                      ),
                      Spacer(),
                      Text(
                        UiUtils.convertTimestampToDate(
                            widget.taskEntity.createdAt),
                        style: getRegularStyle(
                          color: ColorManager.darkGrey1,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_vert,
              size: 24.w,
            )
          ],
        ),
      ),
    );
  }
}

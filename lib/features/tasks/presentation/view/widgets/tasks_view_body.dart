import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/core/resources/assets_manager.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/routes/routes.dart';
import 'package:tasky_app/core/utils/ui_utils.dart';
import 'package:tasky_app/core/utils/validator.dart';
import 'package:tasky_app/core/widgets/custom_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/core/widgets/default_drop_btn.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/post_task_entity.dart';
import 'package:tasky_app/features/tasks/presentation/view/widgets/show_bottom_sheet.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_cubit.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_states.dart';

class TasksViewBody extends StatefulWidget {
  const TasksViewBody({super.key});

  @override
  State<TasksViewBody> createState() => _TasksViewBodyState();
}

class _TasksViewBodyState extends State<TasksViewBody> {
  final List<Enum> _priority = [
    Priority.high,
    Priority.low,
    Priority.medium,
  ];
  final List<Enum> _status = [
    Status.inProgress,
    Status.waiting,
    Status.finished
  ];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _currentDate;
  String _currentPriority = Priority.high.name;
  String _currentStatus = Status.inProgress.name;

  String? _imagePath;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaskEntity taskEntity =
        ModalRoute.of(context)!.settings.arguments as TaskEntity;
    if (taskEntity.id != null && _currentDate == null && _imagePath == null) {
      _imagePath = taskEntity.image
          .toString()
          .split('${EndPoint.baseUrl}${EndPoint.getImage}')
          .join();
      _currentStatus = taskEntity.status ?? _status.first.name;
      _currentPriority = taskEntity.priority ?? _priority.first.name;
      _currentDate =
          UiUtils.convertTimestampToDate(taskEntity.createdAt, 'yyyy-MM-dd');
      _titleController.text = taskEntity.title ?? '';
      _descriptionController.text = taskEntity.desc ?? '';
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Insets.s22.w,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              SizedBox(
                height: 24.h,
              ),
              BlocListener<TasksCubit, TasksStates>(
                listener: (context, state) {
                  if (state is UploadImageLoading) {
                  } else if (state is UploadImageError) {
                    UiUtils.showMessageToast(state.message);
                    _imagePath = null;
                    setState(() {});
                  } else if (state is UploadImageSuccess) {
                    if (state.imageEntity.image != null) {
                      UiUtils.showMessageToast(AppConstants.imageUploaded);
                      _imagePath = state.imageEntity.image;
                    }
                    setState(() {});
                  }
                },
                child: InkWell(
                  onTap: () => showBottomSheetAddImage(context),
                  child: DottedBorder(
                    color: ColorManager.primary,
                    radius: Radius.circular(12.r),
                    borderType: BorderType.RRect,
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.s16.w, vertical: Insets.s16.h),
                    child: Row(
                      spacing: 8.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgAssets.assetsSvgAddImg),
                        Text(
                          AppConstants.addImg,
                          style: getMediumStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s19),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _imagePath != null
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: Insets.s8.h,
                        start: Insets.s8.w,
                      ),
                      child: Text(
                        AppConstants.chooseImageError,
                        style: getRegularStyle(color: ColorManager.red)
                            .copyWith(fontSize: 13.sp),
                      ),
                    ),
              CustomTextFormField(
                controller: _titleController,
                label: AppConstants.taskTitle,
                hint: AppConstants.taskTitleHint,
                validation: Validator.validateName,
              ),
              CustomTextFormField(
                controller: _descriptionController,
                label: AppConstants.taskDescription,
                maxLines: 6,
                hint: AppConstants.taskDescriptionHint,
              ),
              DefaultDropBtn(
                onChanged: (value) {
                  value != null
                      ? _currentPriority = value.toString()
                      : _currentPriority = _priority.first.name;
                  setState(() {});
                },
                label: AppConstants.priority,
                labelTextStyle: getRegularStyle(
                    color: ColorManager.grey3, fontSize: FontSize.s12),
                style: getBoldStyle(
                    color: ColorManager.primary, fontSize: FontSize.s16),
                decoration: InputDecoration(
                  fillColor: UiUtils.changeContainerColor(_currentPriority),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.s12.w),
                    child: UiUtils.changeFlagPriority(_currentPriority),
                  ),
                ),
                icon: UiUtils.changeArrowDrop(_currentPriority),
                currentValue: _currentPriority,
                items: _priority
                    .map(
                      (f) => DropdownMenuItem(
                        value: f.name,
                        child: Text(
                            '${f.name.toUpperCase()} ${AppConstants.priority}',
                            style: getBoldStyle(
                              color: UiUtils.changeTextColor(_currentPriority),
                              fontSize: FontSize.s16,
                            )),
                      ),
                    )
                    .toList(),
              ),
              DefaultDropBtn(
                onChanged: (value) {
                  value != null
                      ? _currentStatus = value.toString()
                      : _currentStatus = _status.first.name;
                  setState(() {});
                },
                label: AppConstants.status,
                labelTextStyle: getRegularStyle(
                    color: ColorManager.grey3, fontSize: FontSize.s12),
                style: getBoldStyle(
                    color: ColorManager.primary, fontSize: FontSize.s16),
                decoration: InputDecoration(
                  fillColor: UiUtils.changeContainerColor(_currentStatus),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                icon: UiUtils.changeArrowDrop(_currentStatus),
                currentValue: _currentStatus,
                items: _status
                    .map(
                      (f) => DropdownMenuItem(
                        value: f.name,
                        child: Text(f.name.toUpperCase(),
                            style: getBoldStyle(
                              color: UiUtils.changeTextColor(_currentStatus),
                              fontSize: FontSize.s16,
                            )),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Insets.s8),
                child: Text(
                  AppConstants.dueDate,
                  textAlign: TextAlign.start,
                  style: getMediumStyle(color: ColorManager.grey3)
                      .copyWith(fontSize: FontSize.s13),
                ),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 1825)),
                          initialDate: DateTime.now())
                      .then((value) => setState(() {
                            if (value != null) {
                              _currentDate = UiUtils.convertTimestampToDate(
                                  value, 'yyyy-MM-dd');
                            } else {
                              _currentDate = null;
                            }
                          }));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Insets.s12.w, vertical: Insets.s16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: ColorManager.darkGrey1,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Text(
                        _currentDate == null || _currentDate == ''
                            ? AppConstants.chooseDueDate
                            : _currentDate!,
                        style: _currentDate != null && _currentDate != ''
                            ? getBoldStyle(color: ColorManager.mainBlack)
                                .copyWith(fontSize: FontSize.s18)
                            : getRegularStyle(color: ColorManager.grey)
                                .copyWith(fontSize: FontSize.s14),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        SvgAssets.assetsSvgCalendar,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),
              _currentDate != null
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: Insets.s8.h,
                        start: Insets.s8.w,
                      ),
                      child: Text(
                        AppConstants.chooseDateError,
                        style: getRegularStyle(color: ColorManager.red)
                            .copyWith(fontSize: 13.sp),
                      ),
                    ),
              SizedBox(
                height: 10.h,
              ),
              BlocListener<TasksCubit, TasksStates>(
                listener: (context, state) {
                  if (state is AddNewTaskLoading || state is EditTaskLoading) {
                    UiUtils.showLoadingDialog(context);
                  } else if (state is AddNewTaskSuccess ||
                      state is EditTaskSuccess) {
                    UiUtils.hideLoadingDialog(context);
                    Navigator.pushReplacementNamed(context, Routes.home);
                  } else if (state is AddNewTaskError ||
                      state is EditTaskError) {
                    UiUtils.hideLoadingDialog(context);
                    UiUtils.showMessageToast(state is AddNewTaskError
                        ? state.message
                        : state is EditTaskError
                            ? state.message
                            : '');
                  }
                },
                child: CustomButton(
                    label: taskEntity.id == null
                        ? AppConstants.addTask
                        : AppConstants.editTask,
                    onTap: () async {
                      if (_imagePath != null && _currentDate != null) {
                        if (_formKey.currentState!.validate()) {
                           AuthCubit.get(context).getNewAccessToken();
                          if (taskEntity.id == null) {
                            await TasksCubit.get(context).addNewTask(
                              PostTaskEntity(
                                image: _imagePath,
                                title: _titleController.text,
                                desc: _descriptionController.text,
                                priority: _currentPriority,
                                status: _currentStatus,
                                dueDate: _currentDate,
                              ),
                            );
                          } else {
                            await TasksCubit.get(context).editTask(
                              PostTaskEntity(
                                image: _imagePath,
                                title: _titleController.text,
                                desc: _descriptionController.text,
                                priority: _currentPriority,
                                status: _currentStatus,
                                dueDate: _currentDate,
                              ),
                              taskEntity.id!,
                            );
                          }
                        }
                      }
                    }),
              ),
              SizedBox(
                height: 24.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

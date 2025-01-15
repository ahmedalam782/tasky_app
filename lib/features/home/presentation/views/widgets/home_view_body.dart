import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/resources/color_manager.dart';
import 'package:tasky_app/core/resources/font_manager.dart';
import 'package:tasky_app/core/resources/styles_manager.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/widgets/loading_indicator.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/domain/entities/task_tab.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_cubit.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_state.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/tab_items.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/task_items.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<TaskTab> _taskTab = [
    TaskTab(id: 1, title: Status.all),
    TaskTab(id: 2, title: Status.inProgress),
    TaskTab(id: 3, title: Status.waiting),
    TaskTab(id: 4, title: Status.finished),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.s16.w,
      ),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text(
            AppConstants.myTasks,
            style: getBoldStyle(
              color: ColorManager.mainBlack.withValues(alpha: 0.6),
              fontSize: FontSize.s16,
            ),
          ),
          DefaultTabController(
            length: _taskTab.length,
            child: TabBar(
              labelPadding: EdgeInsetsDirectional.only(
                start: Insets.s8.w,
              ),
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              onTap: (index) => setState(() {
                _selectedIndex = index;
                _getTasks(context);
              }),
              tabs: _taskTab
                  .map(
                    (taskTab) => TabItems(
                      title: taskTab.title,
                      isSelected: _taskTab.indexOf(taskTab) == _selectedIndex,
                    ),
                  )
                  .toList(),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) => current is! TasksLoadingMore,
            builder: (_, state) {
              if (state is TasksLoading) {
                return Expanded(child: LoadingIndicator());
              } else if (state is TasksError) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "Failed to get tasks",
                      style: getSemiBoldStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (state is TasksSuccess) {
                final List<TaskEntity> tasks = state.tasks;
                return tasks.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "please add tasks to see them here",
                            style: getSemiBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent &&
                              notification is ScrollUpdateNotification) {
                            if (HomeCubit.get(context).hasMore) {
                              _getTasks(context, isFromLoading: true);
                            }
                          }
                          return true;
                        },
                        child: Expanded(
                          child: RefreshIndicator(
                            color: ColorManager.primary,
                            backgroundColor: ColorManager.titanWhite,
                            onRefresh: () => _getTasks(context),
                            child: ScrollConfiguration(
                              behavior: _buildScrollBehavior(context),
                              child: ListView.builder(
                                itemBuilder: (_, index) {
                                  if (index <
                                      HomeCubit.get(context).newTasks.length) {
                                    return TaskItems(
                                      taskEntity: tasks[index],
                                    );
                                  } else {
                                    return HomeCubit.get(context).hasMore
                                        ? LoadingIndicator(
                                            height: 90.h,
                                          )
                                        : const SizedBox();
                                  }
                                },
                                itemCount: tasks.length + 1,
                              ),
                            ),
                          ),
                        ),
                      );
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  ScrollBehavior _buildScrollBehavior(BuildContext context) {
    return ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );
  }

  Future<void> _getTasks(context, {bool isFromLoading = false}) async {
    if (_taskTab[_selectedIndex].title.name.toLowerCase() !=
        "All".toLowerCase()) {
      await AuthCubit.get(context).getNewAccessToken();
      await HomeCubit.get(context).getTasks(
        status: _taskTab[_selectedIndex].title.name.toLowerCase(),
        isFromLoading: isFromLoading,
      );
    } else {
      await AuthCubit.get(context).getNewAccessToken();
      await HomeCubit.get(context).getTasks(isFromLoading: isFromLoading);
    }
  }
}

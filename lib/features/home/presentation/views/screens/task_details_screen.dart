import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/resources/values_manager.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/popup_menu_items.dart';
import 'package:tasky_app/features/home/presentation/views/widgets/task_details_view_body.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskEntity taskEntity =
        ModalRoute.of(context)!.settings.arguments as TaskEntity;
    return BlocProvider(
      create: (context) => serviceLocator.get<TasksCubit>(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          onTap: () {
            Navigator.pop(context);
          },
          title: AppConstants.taskDetails,
          automaticallyImplyLeading: true,
          actions: [
            PopupMenuItems(
              task: taskEntity,
            ),
          ],
        ),
        body: TaskDetailsViewBody(),
      ),
    );
  }
}

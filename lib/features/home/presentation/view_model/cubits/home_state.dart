import 'package:tasky_app/features/home/domain/entities/task_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class TasksLoading extends HomeState {}

class TasksLoadingMore extends HomeState {}

class TasksSuccess extends HomeState {
  List<TaskEntity> tasks;

  TasksSuccess({
    required this.tasks,
  });
}

class TasksError extends HomeState {
  final String message;

  TasksError({
    required this.message,
  });
}

class GetTaskByIdLoading extends HomeState {}

class GetTaskByIdSuccess extends HomeState {
  TaskEntity task;

  GetTaskByIdSuccess({
    required this.task,
  });
}

class GetTaskByIdError extends HomeState {
  final String message;

  GetTaskByIdError({
    required this.message,
  });
}

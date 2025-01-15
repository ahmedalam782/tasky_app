import 'package:tasky_app/features/tasks/domain/entities/image_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/get_task_entity.dart';

abstract class TasksStates {}

class TasksInitial extends TasksStates {}

class UploadImageLoading extends TasksStates {}

class UploadImageSuccess extends TasksStates {
  final ImageEntity imageEntity;
  UploadImageSuccess({required this.imageEntity});
}

class UploadImageError extends TasksStates {
  final String message;
  UploadImageError({required this.message});
}

class AddNewTaskLoading extends TasksStates {}

class AddNewTaskSuccess extends TasksStates {
  final GetTaskEntity taskEntity;
  AddNewTaskSuccess({required this.taskEntity});
}

class AddNewTaskError extends TasksStates {
  final String message;
  AddNewTaskError({required this.message});
}

class EditTaskLoading extends TasksStates {}

class EditTaskSuccess extends TasksStates {
  final GetTaskEntity taskEntity;
  EditTaskSuccess({required this.taskEntity});
}

class EditTaskError extends TasksStates {
  final String message;
  EditTaskError({required this.message});
}

class DeleteTaskLoading extends TasksStates {}

class DeleteTaskSuccess extends TasksStates {
  final GetTaskEntity taskEntity;
  DeleteTaskSuccess({required this.taskEntity});
}

class DeleteTaskError extends TasksStates {
  final String message;
  DeleteTaskError({required this.message});
}

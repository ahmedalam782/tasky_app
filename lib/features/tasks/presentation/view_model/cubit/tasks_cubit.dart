import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/features/tasks/domain/entities/post_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/use_cases/add_new_task.dart';
import 'package:tasky_app/features/tasks/domain/use_cases/delete_task.dart';
import 'package:tasky_app/features/tasks/domain/use_cases/edit_task.dart';
import 'package:tasky_app/features/tasks/domain/use_cases/upload_image.dart';
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_states.dart';

@injectable
class TasksCubit extends Cubit<TasksStates> {
  TasksCubit(
      this._uploadImage, this._addNewTask, this._editTask, this._deleteTask)
      : super(TasksInitial());
  final UploadImage _uploadImage;
  final AddNewTask _addNewTask;
  final EditTask _editTask;
  final DeleteTask _deleteTask;
  static TasksCubit get(context) => BlocProvider.of(context);

  Future<void> uploadImage(ImageSource source) async {
    emit(UploadImageLoading());
    final result = await _uploadImage(source);
    result.fold(
      (failure) {
        emit(UploadImageError(message: failure.message));
      },
      (image) {
        emit(UploadImageSuccess(imageEntity: image));
      },
    );
  }

  Future<void> addNewTask(PostTaskEntity request) async {
    emit(AddNewTaskLoading());
    final result = await _addNewTask(request);
    result.fold(
      (failure) {
        emit(AddNewTaskError(message: failure.message));
      },
      (task) {
        emit(AddNewTaskSuccess(taskEntity: task));
      },
    );
  }

  Future<void> editTask(PostTaskEntity request, String id) async {
    emit(EditTaskLoading());
    final result = await _editTask(request, id);
    result.fold(
      (failure) {
        emit(EditTaskError(message: failure.message));
      },
      (task) {
        emit(EditTaskSuccess(taskEntity: task));
      },
    );
  }

  Future<void> deleteTask(String id) async {
    emit(DeleteTaskLoading());
    final result = await _deleteTask(id);
    result.fold(
      (failure) {
        emit(DeleteTaskError(message: failure.message));
      },
      (task) {
        emit(DeleteTaskSuccess(taskEntity: task));
      },
    );
  }
}

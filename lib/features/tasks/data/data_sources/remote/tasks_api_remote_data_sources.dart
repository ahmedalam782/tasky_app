import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/functions/upload_image_to_api.dart';
import 'package:tasky_app/core/network/remote/api_consumer.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/tasks/data/data_sources/remote/tasks_remote_data_sources.dart';
import 'package:tasky_app/features/tasks/data/models/image_response.dart';
import 'package:tasky_app/features/tasks/data/models/task_request.dart';
import 'package:tasky_app/features/tasks/data/models/task_response.dart';

@LazySingleton(as: TasksRemoteDataSources)
class TasksApiRemoteDataSources extends TasksRemoteDataSources {
  final ApiConsumer _apiConsumer;
  final ImagePicker _imagePicker;
  TasksApiRemoteDataSources(this._apiConsumer, this._imagePicker);
  @override
  Future<ImageResponse> uploadImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 60,
      );
      if (image != null) {
        final response = await _apiConsumer.post(
          isFormData: true,
          EndPoint.uploadImage,
          data: {
            ApiKey.image: await uploadImageToAPI(image),
          },
        );
        return ImageResponse.fromJson(response);
      }
      return ImageResponse();
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to upload image');
    }
  }

  @override
  Future<TaskResponse> addNewTask(TaskRequest request) async {
    try {
      final response = await _apiConsumer.post(
        EndPoint.todos,
        data: request.toJson(),
      );
      return TaskResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to add new task');
    }
  }

  @override
  Future<TaskResponse> editTask(TaskRequest request, String id) async {
    try {
      final response = await _apiConsumer.put(
        '${EndPoint.todos}/$id',
        data: request.toJson(),
      );
      return TaskResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to edit task');
    }
  }

  @override
  Future<TaskResponse> deleteTask(String id) async {
    try {
      final response = await _apiConsumer.delete(
        '${EndPoint.todos}/$id',
      );
      return TaskResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to delete task');
    }
  }
}

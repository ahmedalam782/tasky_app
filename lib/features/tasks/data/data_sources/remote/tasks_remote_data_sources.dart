import 'package:image_picker/image_picker.dart';
import 'package:tasky_app/features/tasks/data/models/image_response.dart';
import 'package:tasky_app/features/tasks/data/models/task_request.dart';
import 'package:tasky_app/features/tasks/data/models/task_response.dart';

abstract class TasksRemoteDataSources {
  Future<ImageResponse> uploadImage(ImageSource source);
  Future<TaskResponse> addNewTask(TaskRequest request);
  Future<TaskResponse> editTask(TaskRequest request, String id);
  Future<TaskResponse> deleteTask(String id);
}

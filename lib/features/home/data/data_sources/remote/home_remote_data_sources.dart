import 'package:tasky_app/features/home/data/models/tasks_response.dart';

abstract class HomeRemoteDataSources {
  Future<List<TasksResponse>> getTasks({int? page, String? status});
  Future<TasksResponse> getTaskByID(String taskId);
}

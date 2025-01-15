import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/remote/api_consumer.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';

import 'package:tasky_app/features/home/data/data_sources/remote/home_remote_data_sources.dart';
import 'package:tasky_app/features/home/data/models/tasks_response.dart';

@LazySingleton(as: HomeRemoteDataSources)
class HomeApiRemoteDataSources implements HomeRemoteDataSources {
  final ApiConsumer _apiConsumer;

  const HomeApiRemoteDataSources(this._apiConsumer);

  @override
  Future<List<TasksResponse>> getTasks({int? page, String? status}) async {
    try {
      final response = status == null && page == null
          ? await _apiConsumer.get(EndPoint.todos)
          : status == null
              ? await _apiConsumer.get(EndPoint.todos, queryParameters: {
                  ApiKey.page: page,
                })
              : await _apiConsumer.get(EndPoint.todos, queryParameters: {
                  ApiKey.page: page,
                  ApiKey.status: status,
                });

      final List<TasksResponse>? tasks = (response as List<dynamic>?)
          ?.map((e) => TasksResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      return tasks ?? [];
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to get tasks');
    }
  }

  @override
  Future<TasksResponse> getTaskByID(String taskId) async {
    try {
      final response = await _apiConsumer.get(
        '${EndPoint.todos}/$taskId',
      );
      return TasksResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to get tasks by ID ');
    }
  }
}

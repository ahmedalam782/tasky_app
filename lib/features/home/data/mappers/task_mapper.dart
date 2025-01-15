import 'package:tasky_app/features/home/data/models/tasks_response.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';

extension TaskMapper on TasksResponse {
  TaskEntity toEntity() => TaskEntity(
        id: id,
        image: image,
        title: title,
        desc: desc,
        priority: priority,
        status: status,
        user: user,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
      );
}

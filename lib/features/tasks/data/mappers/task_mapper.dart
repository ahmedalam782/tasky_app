import 'package:tasky_app/features/tasks/data/models/task_response.dart';
import 'package:tasky_app/features/tasks/domain/entities/get_task_entity.dart';

extension TaskMapper on TaskResponse {
  GetTaskEntity toEntity() => GetTaskEntity(
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

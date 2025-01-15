import 'package:tasky_app/features/tasks/data/models/task_request.dart';
import 'package:tasky_app/features/tasks/domain/entities/post_task_entity.dart';

extension TaskMapper on PostTaskEntity {
  TaskRequest toModel() => TaskRequest(
        image: image,
        title: title,
        desc: desc,
        priority: priority,
        dueDate: dueDate,
        status: status,
      );
}

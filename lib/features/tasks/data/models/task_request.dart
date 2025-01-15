import 'package:tasky_app/core/network/remote/end_point.dart';

class TaskRequest {
 final String? image;
 final String? title;
 final String? desc;
 final String? priority;
 final String? dueDate;
 final String? status;

 const TaskRequest({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.dueDate,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        ApiKey.image: image,
        ApiKey.title: title,
        ApiKey.desc: desc,
        ApiKey.priority: priority,
        ApiKey.dueDate: dueDate,
        ApiKey.status: status,
      };
}

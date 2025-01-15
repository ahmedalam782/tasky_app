import 'package:tasky_app/core/network/remote/end_point.dart';

class TasksResponse {
  final String? id;
  final String? image;
  final String? title;
  final String? desc;
  final String? priority;
  final String? status;
  final String? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const TasksResponse({
    this.id,
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TasksResponse.fromJson(Map<String, dynamic> json) => TasksResponse(
        id: json[ApiKey.id] as String?,
        image: '${EndPoint.baseUrl}${EndPoint.getImage}${json[ApiKey.image]}'
            as String?,
        title: json[ApiKey.title] as String?,
        desc: json[ApiKey.desc] as String?,
        priority: json[ApiKey.priority] as String?,
        status: json[ApiKey.status] as String?,
        user: json[ApiKey.user] as String?,
        createdAt: json[ApiKey.createdAt] == null
            ? null
            : DateTime.parse(json[ApiKey.createdAt] as String),
        updatedAt: json[ApiKey.updatedAt] == null
            ? null
            : DateTime.parse(json[ApiKey.updatedAt] as String),
        v: json[ApiKey.v] as int?,
      );
}

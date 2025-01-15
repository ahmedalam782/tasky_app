import 'package:tasky_app/core/network/remote/end_point.dart';

class TaskResponse {
  final String? image;
  final String? title;
  final String? desc;
  final String? priority;
  final String? status;
  final String? user;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const TaskResponse({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        image: json[ApiKey.image] as String?,
        title: json[ApiKey.title] as String?,
        desc: json[ApiKey.desc] as String?,
        priority: json[ApiKey.priority] as String?,
        status: json[ApiKey.status] as String?,
        user: json[ApiKey.user] as String?,
        id: json[ApiKey.id] as String?,
        createdAt: json[ApiKey.createdAt] == null
            ? null
            : DateTime.parse(json[ApiKey.createdAt] as String),
        updatedAt: json[ApiKey.updatedAt] == null
            ? null
            : DateTime.parse(json[ApiKey.updatedAt] as String),
        v: json[ApiKey.v] as int?,
      );
}

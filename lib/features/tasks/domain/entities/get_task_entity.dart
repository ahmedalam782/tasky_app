class GetTaskEntity {
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

  const GetTaskEntity({
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
}

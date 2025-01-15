import 'package:tasky_app/core/network/remote/end_point.dart';

class ProfileResponse {
  final String? id;
  final String? displayName;
  final String? username;
  final List<dynamic>? roles;
  final bool? active;
  final int? experienceYears;
  final String? address;
  final String? level;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const ProfileResponse({
    this.id,
    this.displayName,
    this.username,
    this.roles,
    this.active,
    this.experienceYears,
    this.address,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json[ApiKey.id] as String?,
      displayName: json[ApiKey.displayName] as String?,
      username: json[ApiKey.username] as String?,
      roles: json[ApiKey.roles] as List<dynamic>?,
      active: json[ApiKey.active] as bool?,
      experienceYears: json[ApiKey.experienceYears] as int?,
      address: json[ApiKey.address] as String?,
      level: json[ApiKey.level] as String?,
      createdAt: json[ApiKey.createdAt] == null
          ? null
          : DateTime.parse(json[ApiKey.createdAt] as String),
      updatedAt: json[ApiKey.updatedAt] == null
          ? null
          : DateTime.parse(json[ApiKey.updatedAt] as String),
      v: json[ApiKey.v] as int?,
    );
  }
}

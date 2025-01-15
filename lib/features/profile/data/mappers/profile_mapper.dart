import 'package:tasky_app/features/profile/data/models/profile_response.dart';
import 'package:tasky_app/features/profile/domain/entities/profile_entity.dart';

extension ProfileMapper on ProfileResponse {
  ProfileEntity toEntity() => ProfileEntity(
        id: id,
        displayName: displayName,
        username: username,
        roles: roles,
        active: active,
        experienceYears: experienceYears,
        address: address,
        level: level,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
      );
}

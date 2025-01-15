import 'package:tasky_app/features/auth/data/models/logout_response.dart';
import 'package:tasky_app/features/auth/domain/entities/logout_entity.dart';

extension LogoutMapper on LogoutResponse {
  LogoutEntity toEntity() => LogoutEntity(
        success: success,
      );
}

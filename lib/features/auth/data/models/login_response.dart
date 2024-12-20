import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';

class LoginResponse {
  final String? id;
  final String? accessToken;
  final String? refreshToken;

  const LoginResponse({
    this.id,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> data) => LoginResponse(
        id: data[ApiKey.id] as String?,
        accessToken: data[ApiKey.accessToken] as String?,
        refreshToken: data[ApiKey.refreshToken] as String?,
      );

  LoginEntity get loginEntity => LoginEntity(
        id: id,
      );
}

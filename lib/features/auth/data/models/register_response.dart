import 'package:tasky_app/core/network/remote/end_point.dart';

class RegisterResponse {
  final String? id;
  final String? displayName;
  final String? accessToken;
  final String? refreshToken;

  const RegisterResponse({
    this.id,
    this.displayName,
    this.accessToken,
    this.refreshToken,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json[ApiKey.id] as String?,
      displayName: json[ApiKey.displayName] as String?,
      accessToken: json[ApiKey.accessToken] as String?,
      refreshToken: json[ApiKey.refreshToken] as String?,
    );
  }
}

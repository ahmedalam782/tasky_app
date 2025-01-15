import 'package:tasky_app/core/network/remote/end_point.dart';

class RefreshTokenResponse {
  final String? accessToken;

  const RefreshTokenResponse({this.accessToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json[ApiKey.accessToken] as String?,
    );
  }
}

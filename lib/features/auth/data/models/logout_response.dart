import 'package:tasky_app/core/network/remote/end_point.dart';

class LogoutResponse {
  final bool? success;

  const LogoutResponse({this.success});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      success: json[ApiKey.success] as bool?,
    );
  }
}

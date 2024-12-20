import 'package:tasky_app/core/network/remote/end_point.dart';

class LoginRequest {
  final String phone;
  final String password;

  const LoginRequest({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        ApiKey.phone: phone,
        ApiKey.password: password,
      };
}

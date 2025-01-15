import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/domain/entities/post_login_entity.dart';

extension LoginMapper on PostLoginEntity {
  LoginRequest toModel() => LoginRequest(
        phone: phone,
        password: password,
      );
}

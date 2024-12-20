import 'package:tasky_app/features/auth/data/models/login_response.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';

extension LoginMapper on LoginResponse {
  LoginEntity toEntity() => LoginEntity(
        id: id,
      );
}

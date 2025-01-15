import 'package:tasky_app/features/auth/data/models/register_response.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';

extension RegisterMapper on RegisterResponse {
  RegisterEntity toEntity() => RegisterEntity(
        id: id,
      );
}

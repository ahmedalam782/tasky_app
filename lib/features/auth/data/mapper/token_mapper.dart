import 'package:tasky_app/features/auth/data/models/refresh_token_response.dart';
import 'package:tasky_app/features/auth/domain/entities/token_entity.dart';

extension TokenMapper on RefreshTokenResponse {
  TokenEntity toEntity() => TokenEntity(
        accessToken: accessToken,
      );
}

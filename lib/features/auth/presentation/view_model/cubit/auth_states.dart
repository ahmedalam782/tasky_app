import 'package:tasky_app/features/auth/domain/entities/logout_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/token_entity.dart';

abstract class AuthStates {}

class AuthInitialStates extends AuthStates {}

class LoginLoadingStates extends AuthStates {}

class LoginSuccessStates extends AuthStates {}

class LoginErrorStates extends AuthStates {
  final String error;

  LoginErrorStates({required this.error});
}

class RegisterLoadingStates extends AuthStates {}

class RegisterSuccessStates extends AuthStates {}

class RegisterErrorStates extends AuthStates {
  final String error;

  RegisterErrorStates({required this.error});
}

class LogOutLoading extends AuthStates {}

class LogOutSuccess extends AuthStates {
  LogoutEntity logout;

  LogOutSuccess({
    required this.logout,
  });
}

class LogOutError extends AuthStates {
  final String message;

  LogOutError({
    required this.message,
  });
}

class AccessTokenLoading extends AuthStates {}

class AccessTokenSuccess extends AuthStates {
  TokenEntity token;

  AccessTokenSuccess({
    required this.token,
  });
}

class AccessTokenError extends AuthStates {
  final String message;

  AccessTokenError({
    required this.message,
  });
}

class SaveAccessTokenLoading extends AuthStates {}

class SaveAccessTokenSuccess extends AuthStates {
  final bool accessToken;

  SaveAccessTokenSuccess({
    required this.accessToken,
  });
}

class SaveAccessTokenError extends AuthStates {
  final String message;

  SaveAccessTokenError({
    required this.message,
  });
}

class SaveRefreshTokenLoading extends AuthStates {}

class SaveRefreshTokenSuccess extends AuthStates {
  final bool refreshToken;

  SaveRefreshTokenSuccess({
    required this.refreshToken,
  });
}

class SaveRefreshTokenError extends AuthStates {
  final String message;

  SaveRefreshTokenError({
    required this.message,
  });
}

class GetRefreshTokenLoading extends AuthStates {}

class GetRefreshTokenSuccess extends AuthStates {
  final String? token;

  GetRefreshTokenSuccess({
    required this.token,
  });
}

class GetRefreshTokenError extends AuthStates {
  final String message;

  GetRefreshTokenError({
    required this.message,
  });
}

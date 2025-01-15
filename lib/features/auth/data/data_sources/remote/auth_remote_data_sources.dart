import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/data/models/login_response.dart';
import 'package:tasky_app/features/auth/data/models/logout_response.dart';
import 'package:tasky_app/features/auth/data/models/refresh_token_response.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/data/models/register_response.dart';

abstract class AuthRemoteDataSources {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<RegisterResponse> register(RegisterRequest registerRequest);
  Future<LogoutResponse> logOut();
  Future<RefreshTokenResponse> getNewAccessToken();
}

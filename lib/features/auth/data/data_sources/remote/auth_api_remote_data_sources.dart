import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/remote/api_consumer.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';
import 'package:tasky_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/data/models/login_response.dart';
import 'package:tasky_app/features/auth/data/models/logout_response.dart';
import 'package:tasky_app/features/auth/data/models/refresh_token_response.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/data/models/register_response.dart';

@Singleton(as: AuthRemoteDataSources)
class AuthApiRemoteDataSources implements AuthRemoteDataSources {
  final ApiConsumer _apiConsumer;
  final AuthLocalDataSources _authLocalDataSources;
  const AuthApiRemoteDataSources(this._apiConsumer, this._authLocalDataSources);
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final response = await _apiConsumer.post(
        EndPoint.login,
        data: loginRequest.toJson(),
      );
      return LoginResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to login');
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    try {
      final response = await _apiConsumer.post(
        EndPoint.register,
        data: registerRequest.toJson(),
      );
      return RegisterResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to register');
    }
  }

  @override
  Future<LogoutResponse> logOut() async {
    String? refreshToken = _authLocalDataSources.getRefreshToken();
    try {
      final response = await _apiConsumer.post(EndPoint.logOut, data: {
        ApiKey.token: refreshToken,
      });
      return LogoutResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to log out');
    }
  }

  @override
  Future<RefreshTokenResponse> getNewAccessToken() async {
    String? refreshToken = _authLocalDataSources.getRefreshToken();
    try {
      final response =
          await _apiConsumer.get(EndPoint.refreshToken, queryParameters: {
        ApiKey.token: refreshToken,
      });
      return RefreshTokenResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to get new access token');
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/errors/exception.dart';
import 'package:tasky_app/core/network/remote/api_consumer.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/data/models/login_response.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/data/models/register_response.dart';

@Singleton(as: AuthRemoteDataSources)
class AuthApiRemoteDataSources implements AuthRemoteDataSources {
  final ApiConsumer _apiConsumer;

  AuthApiRemoteDataSources(this._apiConsumer);
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
}

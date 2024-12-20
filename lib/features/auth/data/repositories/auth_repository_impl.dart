import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/errors/exception.dart';
import 'package:tasky_app/core/errors/failure.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';
import 'package:tasky_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:tasky_app/features/auth/data/mappers/login_mapper.dart';
import 'package:tasky_app/features/auth/data/mappers/register_mapper.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources _authRemoteDataSources;
  final AuthLocalDataSources _authLocalDataSources;
  const AuthRepositoryImpl(
    this._authRemoteDataSources,
    this._authLocalDataSources,
  );

  @override
  Future<Either<Failure, LoginEntity>> login(LoginRequest loginRequest) async {
    try {
      final response = await _authRemoteDataSources.login(loginRequest);
      await _authLocalDataSources.saveAccessToken(response.accessToken!);
      await _authLocalDataSources.saveRefreshToken(response.refreshToken!);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(
      RegisterRequest registerRequest) async {
    try {
      final response = await _authRemoteDataSources.register(registerRequest);
      await _authLocalDataSources.saveAccessToken(response.accessToken!);
      await _authLocalDataSources.saveRefreshToken(response.refreshToken!);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

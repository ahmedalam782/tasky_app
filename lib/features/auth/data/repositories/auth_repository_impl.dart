import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';
import 'package:tasky_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:tasky_app/features/auth/data/mapper/login_mapper.dart';
import 'package:tasky_app/features/auth/data/mapper/register_mapper.dart';
import 'package:tasky_app/features/auth/data/mapper/token_mapper.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/logout_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/post_login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/post_register_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/token_entity.dart';
import 'package:tasky_app/features/auth/domain/mapper/login_mapper.dart';
import 'package:tasky_app/features/auth/domain/mapper/register_mapper.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky_app/features/auth/data/mapper/logout_mapper.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources _authRemoteDataSources;
  final AuthLocalDataSources _authLocalDataSources;
  const AuthRepositoryImpl(
    this._authRemoteDataSources,
    this._authLocalDataSources,
  );

  @override
  Future<Either<Failure, LoginEntity>> login(
      PostLoginEntity loginRequest) async {
    try {
      final response =
          await _authRemoteDataSources.login(loginRequest.toModel());
      await _authLocalDataSources.saveAccessToken(response.accessToken!);
      await _authLocalDataSources.saveRefreshToken(response.refreshToken!);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(
      PostRegisterEntity registerRequest) async {
    try {
      final response =
          await _authRemoteDataSources.register(registerRequest.toModel());
      await _authLocalDataSources.saveAccessToken(response.accessToken!);
      await _authLocalDataSources.saveRefreshToken(response.refreshToken!);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LogoutEntity>> logOut() async {
    try {
      final response = await _authRemoteDataSources.logOut();
      await _authLocalDataSources.saveAccessToken("");
      await _authLocalDataSources.saveRefreshToken("");
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> getNewAccessToken() async {
    try {
      final response = await _authRemoteDataSources.getNewAccessToken();
      await _authLocalDataSources.saveAccessToken(response.accessToken!);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveAccessToken(String token) async {
    try {
      final bool accessToken =
          await _authLocalDataSources.saveAccessToken(token);
      return Right(accessToken);
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveRefreshToken(String token) async {
    try {
      final bool refreshToken =
          await _authLocalDataSources.saveRefreshToken(token);
      return Right(refreshToken);
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Either<Failure, String?> getRefreshToken() {
    try {
      final refreshToken = _authLocalDataSources.getRefreshToken();
      return Right(refreshToken);
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

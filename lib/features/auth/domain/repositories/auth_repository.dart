import 'package:dartz/dartz.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/logout_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/post_login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/post_register_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(PostLoginEntity loginRequest);
  Future<Either<Failure, RegisterEntity>> register(
      PostRegisterEntity registerRequest);

  Future<Either<Failure, LogoutEntity>> logOut();

  Future<Either<Failure, TokenEntity>> getNewAccessToken();

  Future<Either<Failure, bool>> saveAccessToken(String token);
  Future<Either<Failure, bool>> saveRefreshToken(String token);

  Either<Failure, String?> getRefreshToken();
}

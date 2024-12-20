import 'package:dartz/dartz.dart';
import 'package:tasky_app/core/errors/failure.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(LoginRequest loginRequest);
  Future<Either<Failure, RegisterEntity>> register(
      RegisterRequest registerRequest);
}

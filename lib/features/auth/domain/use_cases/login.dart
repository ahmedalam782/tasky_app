import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/errors/failure.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';
@singleton
class Login {
  final AuthRepository _authRepository;

 const Login(this._authRepository);

  Future<Either<Failure, LoginEntity>> call(LoginRequest loginRequest) =>
      _authRepository.login(loginRequest);
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/entities/login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/post_login_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class Login {
  final AuthRepository _authRepository;

  const Login(this._authRepository);

  Future<Either<Failure, LoginEntity>> call(PostLoginEntity loginRequest) =>
      _authRepository.login(loginRequest);
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/entities/post_register_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class Register {
  final AuthRepository _authRepository;

  const Register(this._authRepository);

  Future<Either<Failure, RegisterEntity>> call(
          PostRegisterEntity registerRequest) =>
      _authRepository.register(registerRequest);
}

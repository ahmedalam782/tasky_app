import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/errors/failure.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/domain/entities/register_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@singleton
class Register {
  final AuthRepository _authRepository;

 const Register(this._authRepository);

  Future<Either<Failure, RegisterEntity>> call(
          RegisterRequest registerRequest) =>
      _authRepository.register(registerRequest);
}

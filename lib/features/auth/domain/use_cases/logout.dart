import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/entities/logout_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class Logout {
  final AuthRepository _authRepository;
  const Logout(this._authRepository);
  Future<Either<Failure, LogoutEntity>> call() => _authRepository.logOut();
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class SaveRefreshToken {
  final AuthRepository _authRepository;

  const SaveRefreshToken(this._authRepository);

  Future<Either<Failure, bool>> call(String token) =>
      _authRepository.saveRefreshToken(token);
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class RefreshToken {
  final AuthRepository _authRepository;

  const RefreshToken(this._authRepository);

  Either<Failure, String?> call() => _authRepository.getRefreshToken();
}

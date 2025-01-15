import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/auth/domain/entities/token_entity.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class AccessToken {
  final AuthRepository _authRepository;

  const AccessToken(this._authRepository);

  Future<Either<Failure, TokenEntity>> call() =>
      _authRepository.getNewAccessToken();
}

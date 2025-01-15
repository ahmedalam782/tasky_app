import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/profile/domain/entities/profile_entity.dart';
import 'package:tasky_app/features/profile/domain/repositories/profile_repository.dart';

@LazySingleton()
class Profile {
  final ProfileRepository _profileRepository;
  const Profile(this._profileRepository);

  Future<Either<Failure, ProfileEntity>> call() =>
      _profileRepository.getProfile();
}

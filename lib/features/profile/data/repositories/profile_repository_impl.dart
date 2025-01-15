import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/profile/data/data_sources/remote/profile_remote_data_sources.dart';
import 'package:tasky_app/features/profile/data/mappers/profile_mapper.dart';
import 'package:tasky_app/features/profile/domain/entities/profile_entity.dart';
import 'package:tasky_app/features/profile/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSources _profileRemoteDataSources;
  const ProfileRepositoryImpl(this._profileRemoteDataSources);
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final result = await _profileRemoteDataSources.getProfile();
      return Right(result.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

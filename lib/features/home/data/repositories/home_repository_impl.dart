import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/home/data/data_sources/remote/home_remote_data_sources.dart';
import 'package:tasky_app/features/home/data/mappers/task_mapper.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSources _homeRemoteDataSources;
  const HomeRepositoryImpl(
    this._homeRemoteDataSources,
  );
  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks(
      {int? page, String? status}) async {
    try {
      final response =
          await _homeRemoteDataSources.getTasks(page: page, status: status);
      final List<TaskEntity> tasks = response.map((e) => e.toEntity()).toList();
      return Right(tasks);
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTaskByID(String taskId) async {
    try {
      final response = await _homeRemoteDataSources.getTaskByID(taskId);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

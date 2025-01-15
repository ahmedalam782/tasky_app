import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/tasks/data/data_sources/remote/tasks_remote_data_sources.dart';
import 'package:tasky_app/features/tasks/data/mappers/image_mapper.dart';
import 'package:tasky_app/features/tasks/data/mappers/task_mapper.dart';
import 'package:tasky_app/features/tasks/domain/entities/image_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/get_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/post_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/mappers/task_mappers.dart';
import 'package:tasky_app/features/tasks/domain/repositories/task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl extends TaskRepository {
  final TasksRemoteDataSources _tasksRemoteDataSources;

   TaskRepositoryImpl(this._tasksRemoteDataSources);
  @override
  Future<Either<Failure, ImageEntity>> uploadImage(ImageSource source) async {
    try {
      final response = await _tasksRemoteDataSources.uploadImage(source);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTaskEntity>> addNewTask(
      PostTaskEntity request) async {
    try {
      final response =
          await _tasksRemoteDataSources.addNewTask(request.toModel());
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTaskEntity>> deleteTask(String id) async {
    try {
      final response = await _tasksRemoteDataSources.deleteTask(id);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTaskEntity>> editTask(
      PostTaskEntity request, String id) async {
    try {
      final response =
          await _tasksRemoteDataSources.editTask(request.toModel(), id);
      return Right(response.toEntity());
    } on AppException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks(
      {int? page, String? status});
  Future<Either<Failure, TaskEntity>> getTaskByID(String taskId);
}

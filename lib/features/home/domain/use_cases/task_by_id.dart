import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/domain/repositories/home_repository.dart';

@LazySingleton()
class TaskById {
  final HomeRepository _homeRepository;
  const TaskById(this._homeRepository);

  Future<Either<Failure, TaskEntity>> call(String taskId) =>
      _homeRepository.getTaskByID(taskId);
}

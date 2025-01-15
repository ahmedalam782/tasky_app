import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/tasks/domain/entities/get_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/repositories/task_repository.dart';

@LazySingleton()
class DeleteTask {
  final TaskRepository _taskRepository;
 const DeleteTask(this._taskRepository);

  Future<Either<Failure, GetTaskEntity>> call(String id) =>
      _taskRepository.deleteTask(id);
}

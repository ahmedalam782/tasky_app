import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/tasks/domain/entities/get_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/post_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/repositories/task_repository.dart';

@LazySingleton()
class EditTask {
  final TaskRepository _taskRepository;
 const EditTask(this._taskRepository);

  Future<Either<Failure, GetTaskEntity>> call(
          PostTaskEntity request, String id) =>
      _taskRepository.editTask(request, id);
}

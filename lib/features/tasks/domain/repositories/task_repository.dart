import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky_app/features/tasks/domain/entities/image_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/get_task_entity.dart';
import 'package:tasky_app/features/tasks/domain/entities/post_task_entity.dart';

import '../../../../core/network/errors/failure.dart';

abstract class TaskRepository {
  Future<Either<Failure, ImageEntity>> uploadImage(ImageSource source);
  Future<Either<Failure, GetTaskEntity>> addNewTask(PostTaskEntity request);
  Future<Either<Failure, GetTaskEntity>> editTask(
      PostTaskEntity request, String id);
  Future<Either<Failure, GetTaskEntity>> deleteTask(String id);
}

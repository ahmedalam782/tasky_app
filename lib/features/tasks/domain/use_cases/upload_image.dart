import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/tasks/domain/entities/image_entity.dart';
import 'package:tasky_app/features/tasks/domain/repositories/task_repository.dart';

@LazySingleton()
class UploadImage {
  final TaskRepository _taskRepository;

  const UploadImage(this._taskRepository);

  Future<Either<Failure, ImageEntity>> call(ImageSource source) =>
      _taskRepository.uploadImage(source);
}

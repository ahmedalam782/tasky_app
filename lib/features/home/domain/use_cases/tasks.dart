import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/failure.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/domain/repositories/home_repository.dart';

@LazySingleton()
class Tasks {
  final HomeRepository _homeRepository;
  const Tasks(this._homeRepository);

  Future<Either<Failure, List<TaskEntity>>> call({int? page, String? status}) =>
      _homeRepository.getTasks(page: page, status: status);
}

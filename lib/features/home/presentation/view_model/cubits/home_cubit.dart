import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/features/home/domain/entities/task_entity.dart';
import 'package:tasky_app/features/home/domain/use_cases/task_by_id.dart';
import 'package:tasky_app/features/home/domain/use_cases/tasks.dart';
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final Tasks _tasks;
  final TaskById _taskById;
  HomeCubit(
    this._tasks,
    this._taskById,
  ) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  int _page = 1;
  List<TaskEntity> newTasks = [];
  bool hasMore = false;

  Future<void> getTasks({bool isFromLoading = false, String? status}) async {
    if (isFromLoading) {
      emit(TasksLoadingMore());
    } else {
      _page = 1;
      newTasks = [];
      emit(TasksLoading());
    }
    final result = await _tasks(page: _page, status: status);
    result.fold(
      (failure) {
        emit(TasksError(
          message: failure.message,
        ));
      },
      (tasks) {
        if (tasks.isNotEmpty) {
          if (tasks.length < 13) {
            hasMore = false;
          } else {
            hasMore = true;
          }
          newTasks.addAll(tasks);
          _page++;
        } else {
          _page = 1;
          tasks = [];
          hasMore = false;
        }
        emit(TasksSuccess(
          tasks: newTasks,
        ));
      },
    );
  }

  Future<void> getTaskById(String taskId) async {
    emit(GetTaskByIdLoading());
    final result = await _taskById(taskId);
    result.fold(
      (failure) {
        emit(GetTaskByIdError(
          message: failure.message,
        ));
      },
      (task) {
        emit(GetTaskByIdSuccess(
          task: task,
        ));
      },
    );
  }
}

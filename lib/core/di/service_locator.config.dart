// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:tasky_app/core/di/register_modules.dart' as _i664;
import 'package:tasky_app/core/network/local/cache_helper.dart' as _i400;
import 'package:tasky_app/core/network/local/shared_preferences_cashed.dart'
    as _i225;
import 'package:tasky_app/core/network/remote/api_consumer.dart' as _i1048;
import 'package:tasky_app/core/network/remote/dio_consumer.dart' as _i845;
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart'
    as _i664;
import 'package:tasky_app/features/auth/data/data_sources/local/auth_shared_local_data_sources.dart'
    as _i899;
import 'package:tasky_app/features/auth/data/data_sources/remote/auth_api_remote_data_sources.dart'
    as _i269;
import 'package:tasky_app/features/auth/data/data_sources/remote/auth_remote_data_sources.dart'
    as _i641;
import 'package:tasky_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i74;
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart'
    as _i536;
import 'package:tasky_app/features/auth/domain/use_cases/access_token.dart'
    as _i556;
import 'package:tasky_app/features/auth/domain/use_cases/login.dart' as _i415;
import 'package:tasky_app/features/auth/domain/use_cases/logout.dart' as _i317;
import 'package:tasky_app/features/auth/domain/use_cases/refresh_token.dart'
    as _i475;
import 'package:tasky_app/features/auth/domain/use_cases/register.dart'
    as _i379;
import 'package:tasky_app/features/auth/domain/use_cases/save_access_token.dart'
    as _i763;
import 'package:tasky_app/features/auth/domain/use_cases/save_refresh_token.dart'
    as _i578;
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart'
    as _i691;
import 'package:tasky_app/features/home/data/data_sources/remote/home_api_remote_data_sources.dart'
    as _i90;
import 'package:tasky_app/features/home/data/data_sources/remote/home_remote_data_sources.dart'
    as _i237;
import 'package:tasky_app/features/home/data/repositories/home_repository_impl.dart'
    as _i766;
import 'package:tasky_app/features/home/domain/repositories/home_repository.dart'
    as _i422;
import 'package:tasky_app/features/home/domain/use_cases/task_by_id.dart'
    as _i568;
import 'package:tasky_app/features/home/domain/use_cases/tasks.dart' as _i330;
import 'package:tasky_app/features/home/presentation/view_model/cubits/home_cubit.dart'
    as _i856;
import 'package:tasky_app/features/profile/data/data_sources/remote/profile_api_remote_data_sources.dart'
    as _i779;
import 'package:tasky_app/features/profile/data/data_sources/remote/profile_remote_data_sources.dart'
    as _i523;
import 'package:tasky_app/features/profile/data/repositories/profile_repository_impl.dart'
    as _i721;
import 'package:tasky_app/features/profile/domain/repositories/profile_repository.dart'
    as _i911;
import 'package:tasky_app/features/profile/domain/use_cases/profile.dart'
    as _i969;
import 'package:tasky_app/features/profile/presentation/view_model/cubit/profile_cubit.dart'
    as _i1025;
import 'package:tasky_app/features/tasks/data/data_sources/remote/tasks_api_remote_data_sources.dart'
    as _i653;
import 'package:tasky_app/features/tasks/data/data_sources/remote/tasks_remote_data_sources.dart'
    as _i761;
import 'package:tasky_app/features/tasks/data/repositories/task_repository_impl.dart'
    as _i890;
import 'package:tasky_app/features/tasks/domain/repositories/task_repository.dart'
    as _i508;
import 'package:tasky_app/features/tasks/domain/use_cases/add_new_task.dart'
    as _i469;
import 'package:tasky_app/features/tasks/domain/use_cases/delete_task.dart'
    as _i582;
import 'package:tasky_app/features/tasks/domain/use_cases/edit_task.dart'
    as _i732;
import 'package:tasky_app/features/tasks/domain/use_cases/upload_image.dart'
    as _i4;
import 'package:tasky_app/features/tasks/presentation/view_model/cubit/tasks_cubit.dart'
    as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.instance,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.singleton<_i400.CacheHelper>(
        () => _i225.SharedPreferencesCashed(gh<_i460.SharedPreferences>()));
    gh.singleton<_i664.AuthLocalDataSources>(
        () => _i899.AuthSharedLocalDataSources(gh<_i400.CacheHelper>()));
    gh.singleton<_i1048.ApiConsumer>(() => _i845.DioConsumer(
          gh<_i361.Dio>(),
          gh<_i664.AuthLocalDataSources>(),
        ));
    gh.lazySingleton<_i237.HomeRemoteDataSources>(
        () => _i90.HomeApiRemoteDataSources(gh<_i1048.ApiConsumer>()));
    gh.lazySingleton<_i761.TasksRemoteDataSources>(
        () => _i653.TasksApiRemoteDataSources(
              gh<_i1048.ApiConsumer>(),
              gh<_i183.ImagePicker>(),
            ));
    gh.lazySingleton<_i422.HomeRepository>(
        () => _i766.HomeRepositoryImpl(gh<_i237.HomeRemoteDataSources>()));
    gh.lazySingleton<_i523.ProfileRemoteDataSources>(
        () => _i779.ProfileApiRemoteDataSources(gh<_i1048.ApiConsumer>()));
    gh.lazySingleton<_i508.TaskRepository>(
        () => _i890.TaskRepositoryImpl(gh<_i761.TasksRemoteDataSources>()));
    gh.lazySingleton<_i911.ProfileRepository>(() =>
        _i721.ProfileRepositoryImpl(gh<_i523.ProfileRemoteDataSources>()));
    gh.singleton<_i641.AuthRemoteDataSources>(
        () => _i269.AuthApiRemoteDataSources(
              gh<_i1048.ApiConsumer>(),
              gh<_i664.AuthLocalDataSources>(),
            ));
    gh.lazySingleton<_i469.AddNewTask>(
        () => _i469.AddNewTask(gh<_i508.TaskRepository>()));
    gh.lazySingleton<_i732.EditTask>(
        () => _i732.EditTask(gh<_i508.TaskRepository>()));
    gh.lazySingleton<_i582.DeleteTask>(
        () => _i582.DeleteTask(gh<_i508.TaskRepository>()));
    gh.lazySingleton<_i4.UploadImage>(
        () => _i4.UploadImage(gh<_i508.TaskRepository>()));
    gh.factory<_i460.TasksCubit>(() => _i460.TasksCubit(
          gh<_i4.UploadImage>(),
          gh<_i469.AddNewTask>(),
          gh<_i732.EditTask>(),
          gh<_i582.DeleteTask>(),
        ));
    gh.lazySingleton<_i330.Tasks>(
        () => _i330.Tasks(gh<_i422.HomeRepository>()));
    gh.lazySingleton<_i568.TaskById>(
        () => _i568.TaskById(gh<_i422.HomeRepository>()));
    gh.singleton<_i536.AuthRepository>(() => _i74.AuthRepositoryImpl(
          gh<_i641.AuthRemoteDataSources>(),
          gh<_i664.AuthLocalDataSources>(),
        ));
    gh.factory<_i856.HomeCubit>(() => _i856.HomeCubit(
          gh<_i330.Tasks>(),
          gh<_i568.TaskById>(),
        ));
    gh.lazySingleton<_i969.Profile>(
        () => _i969.Profile(gh<_i911.ProfileRepository>()));
    gh.lazySingleton<_i415.Login>(
        () => _i415.Login(gh<_i536.AuthRepository>()));
    gh.lazySingleton<_i379.Register>(
        () => _i379.Register(gh<_i536.AuthRepository>()));
    gh.lazySingleton<_i556.AccessToken>(
        () => _i556.AccessToken(gh<_i536.AuthRepository>()));
    gh.lazySingleton<_i578.SaveRefreshToken>(
        () => _i578.SaveRefreshToken(gh<_i536.AuthRepository>()));
    gh.lazySingleton<_i317.Logout>(
        () => _i317.Logout(gh<_i536.AuthRepository>()));
    gh.lazySingleton<_i763.SaveAccessToken>(
        () => _i763.SaveAccessToken(gh<_i536.AuthRepository>()));
    gh.lazySingleton<_i475.RefreshToken>(
        () => _i475.RefreshToken(gh<_i536.AuthRepository>()));
    gh.factory<_i1025.ProfileCubit>(
        () => _i1025.ProfileCubit(gh<_i969.Profile>()));
    gh.singleton<_i691.AuthCubit>(() => _i691.AuthCubit(
          gh<_i379.Register>(),
          gh<_i415.Login>(),
          gh<_i317.Logout>(),
          gh<_i556.AccessToken>(),
          gh<_i763.SaveAccessToken>(),
          gh<_i475.RefreshToken>(),
          gh<_i578.SaveRefreshToken>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i664.RegisterModule {}

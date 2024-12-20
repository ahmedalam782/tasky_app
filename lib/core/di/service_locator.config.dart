// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
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
import 'package:tasky_app/features/auth/domain/use_cases/login.dart' as _i415;
import 'package:tasky_app/features/auth/domain/use_cases/register.dart'
    as _i379;
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_cubit.dart'
    as _i691;

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
    gh.singleton<_i1048.ApiConsumer>(() => _i845.DioConsumer(gh<_i361.Dio>()));
    gh.singleton<_i641.AuthRemoteDataSources>(
        () => _i269.AuthApiRemoteDataSources(gh<_i1048.ApiConsumer>()));
    gh.singleton<_i400.CacheHelper>(
        () => _i225.SharedPreferencesCashed(gh<_i460.SharedPreferences>()));
    gh.singleton<_i664.AuthLocalDataSources>(
        () => _i899.AuthSharedLocalDataSources(gh<_i400.CacheHelper>()));
    gh.singleton<_i536.AuthRepository>(() => _i74.AuthRepositoryImpl(
          gh<_i641.AuthRemoteDataSources>(),
          gh<_i664.AuthLocalDataSources>(),
        ));
    gh.singleton<_i379.Register>(
        () => _i379.Register(gh<_i536.AuthRepository>()));
    gh.singleton<_i415.Login>(() => _i415.Login(gh<_i536.AuthRepository>()));
    gh.singleton<_i691.AuthCubit>(() => _i691.AuthCubit(
          gh<_i379.Register>(),
          gh<_i415.Login>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i664.RegisterModule {}

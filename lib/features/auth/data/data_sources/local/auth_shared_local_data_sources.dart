import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/local/cache_helper.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';

@Singleton(as: AuthLocalDataSources)
class AuthSharedLocalDataSources implements AuthLocalDataSources {
  final CacheHelper _cacheHelper;

  const AuthSharedLocalDataSources(this._cacheHelper);
  @override
  Future<bool> saveAccessToken(String? token) async {
    try {
      return await _cacheHelper.saveData(key: ApiKey.accessToken, value: token);
    } catch (e) {
      throw const LocalException('Failed to save access token');
    }
  }

  @override
  String? getAccessToken() {
    try {
      return _cacheHelper.getData(key: ApiKey.accessToken);
    } catch (e) {
      throw const LocalException('Failed to get access token');
    }
  }

  @override
  Future<bool> saveRefreshToken(String? token) async {
    try {
      return await _cacheHelper.saveData(
          key: ApiKey.refreshToken, value: token);
    } catch (e) {
      throw const LocalException('Failed to save refresh token');
    }
  }

  @override
  String? getRefreshToken() {
    try {
      return _cacheHelper.getData(
        key: ApiKey.refreshToken,
      );
    } catch (e) {
      throw const LocalException('Failed to get refresh token');
    }
  }
}

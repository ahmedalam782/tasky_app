import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_helper.dart';

@Singleton(as: CacheHelper)
class SharedPreferencesCashed implements CacheHelper {
  final SharedPreferences instance;

  const SharedPreferencesCashed(this.instance);

  @override
  String? getDataString({required String key}) {
    return instance.getString(key);
  }

//! this method to put data in local database using key
  @override
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await instance.setBool(key, value);
    }

    if (value is String) {
      return await instance.setString(key, value);
    }

    if (value is int) {
      return await instance.setInt(key, value);
    } else {
      return await instance.setDouble(key, value);
    }
  }

//! this method to get data already saved in local database
  @override
  dynamic getData({required String key}) {
    return instance.get(key);
  }

//! remove data using specific key
  @override
  Future<bool> removeData({required String key}) async {
    return await instance.remove(key);
  }

//! this method to check if local database contains {key}
  @override
  Future<bool> containsKey({required String key}) async {
    return instance.containsKey(key);
  }

  @override
  Future<bool> clearData({required String key}) async {
    return instance.clear();
  }

  @override
//! this fun to put data in local data base using key
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await instance.setString(key, value);
    } else if (value is bool) {
      return await instance.setBool(key, value);
    } else {
      return await instance.setInt(key, value);
    }
  }
}

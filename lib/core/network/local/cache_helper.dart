abstract class CacheHelper {
  String? getDataString({required String key});

//! this method to put data in local database using key

  Future<bool> saveData({required String key, required dynamic value});

//! this method to get data already saved in local database

  dynamic getData({required String key});

//! remove data using specific key

  Future<bool> removeData({required String key});

//! this method to check if local database contains {key}
  Future<bool> containsKey({required String key});

//! this method to clear all data in local database
  Future<bool> clearData({required String key});

//! this fun to put data in local data base using key
  Future<dynamic> put({
    required String key,
    required dynamic value,
  });
}

abstract class AuthLocalDataSources {
  Future<bool> saveAccessToken(String? token);
  Future<bool> saveRefreshToken(String? token);

  String? getAccessToken();
  String? getRefreshToken();
}

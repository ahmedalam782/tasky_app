abstract class AuthLocalDataSources {
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);

  String? getAccessToken();
  String? getRefreshToken();
}

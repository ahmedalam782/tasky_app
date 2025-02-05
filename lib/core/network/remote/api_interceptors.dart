import 'package:dio/dio.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';

class ApiInterceptors extends Interceptor {
  final AuthLocalDataSources _authLocalDataSources;
  const ApiInterceptors(
    this._authLocalDataSources,
  );
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = _authLocalDataSources.getAccessToken();
    options.headers[ApiKey.authorization] = 'Bearer ${token ?? ''}';
    super.onRequest(options, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
       
    }
    super.onError(err, handler);
  }
}

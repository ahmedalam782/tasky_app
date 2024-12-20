import 'package:dio/dio.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = serviceLocator.get<AuthLocalDataSources>().getAccessToken();
    options.headers[ApiKey.authorization] = 'Bearer ${token ?? ''}';
    super.onRequest(options, handler);
  }
}

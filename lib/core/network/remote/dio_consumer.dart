import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/remote/api_consumer.dart';

import 'package:tasky_app/core/network/remote/api_interceptors.dart';
import 'package:tasky_app/features/auth/data/data_sources/local/auth_local_data_sources.dart';

@Singleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio dio;
  final AuthLocalDataSources _authLocalDataSources;

  DioConsumer(
    this.dio,
    this._authLocalDataSources,
  ) {
    dio.interceptors.add(
      ApiInterceptors(
        _authLocalDataSources,
      ),
    ); // For add token in request header of interceptors
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      error: true,
    )); // For print logs of interceptors in console
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }

  @override
  Future<dynamic> request(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Options? options}) async {
    try {
      final response = await dio.request(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      ServerException.handleDioException(e);
    }
  }
}

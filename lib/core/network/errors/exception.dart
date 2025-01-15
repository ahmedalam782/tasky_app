import 'package:dio/dio.dart';
import 'package:tasky_app/core/network/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  const ServerException(this.errorModel);
  static void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.sendTimeout:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.receiveTimeout:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.badCertificate:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.connectionError:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.unknown:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.cancel:
        throw ServerException(ErrorModel.fromMap(e.response!.data));
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: //Bad Request
            throw ServerException(ErrorModel.fromMap(e.response!.data));
          case 401: //Unauthorized
            throw ServerException(ErrorModel.fromMap(e.response!.data));
          case 403: //Forbidden
            throw ServerException(ErrorModel.fromMap(e.response!.data));
          case 404: //Not Found
            throw ServerException(ErrorModel.fromMap(e.response!.data));
          case 500: //Internal Server Error
            throw ServerException(ErrorModel.fromMap(e.response!.data));
          default:
            throw ServerException(ErrorModel.fromMap(e.response!.data));
        }
    }
  }
}

abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class RemoteException extends AppException {
  const RemoteException(super.message);
}

class LocalException extends AppException {
  const LocalException(super.message);
}

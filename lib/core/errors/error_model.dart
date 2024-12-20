import 'package:tasky_app/core/network/remote/end_point.dart';

class ErrorModel {
  int? statusCode;
  String? message;
  String? error;

  ErrorModel({this.statusCode, this.message, this.error});

  factory ErrorModel.fromMap(Map<String, dynamic> data) => ErrorModel(
        statusCode: data[ApiKey.statusCode] as int?,
        message: data[ApiKey.message] as String?,
        error: data[ApiKey.error] as String?,
      );
}

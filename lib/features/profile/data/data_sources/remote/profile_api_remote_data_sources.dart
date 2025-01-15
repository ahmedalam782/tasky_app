import 'package:injectable/injectable.dart';
import 'package:tasky_app/core/network/errors/exception.dart';
import 'package:tasky_app/core/network/remote/api_consumer.dart';
import 'package:tasky_app/core/network/remote/end_point.dart';
import 'package:tasky_app/features/profile/data/data_sources/remote/profile_remote_data_sources.dart';
import 'package:tasky_app/features/profile/data/models/profile_response.dart';

@LazySingleton(as: ProfileRemoteDataSources)
class ProfileApiRemoteDataSources implements ProfileRemoteDataSources {
  final ApiConsumer _apiConsumer;
  const ProfileApiRemoteDataSources(this._apiConsumer);
  @override
  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _apiConsumer.get(
        EndPoint.profile,
      );
      return ProfileResponse.fromJson(response);
    } on ServerException catch (e) {
      String? message = e.errorModel.message;
      throw RemoteException(message ?? 'Failed to get tasks');
    }
  }
}

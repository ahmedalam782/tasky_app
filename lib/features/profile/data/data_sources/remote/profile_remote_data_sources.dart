import 'package:tasky_app/features/profile/data/models/profile_response.dart';

abstract class ProfileRemoteDataSources {
  Future<ProfileResponse> getProfile();
}

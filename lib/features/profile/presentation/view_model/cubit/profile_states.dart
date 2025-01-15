import 'package:tasky_app/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class GetProfileLoading extends ProfileStates {}

class GetProfileSuccess extends ProfileStates {
  final ProfileEntity profileEntity;

  GetProfileSuccess({required this.profileEntity});
}

class GetProfileError extends ProfileStates {
  final String message;

  GetProfileError({required this.message});
}

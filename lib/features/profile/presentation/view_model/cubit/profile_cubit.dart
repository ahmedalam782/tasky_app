import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/features/profile/domain/use_cases/profile.dart';
import 'package:tasky_app/features/profile/presentation/view_model/cubit/profile_states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this._profile) : super(ProfileInitial());
  final Profile _profile;
  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await _profile();
    result.fold(
      (failure) => emit(
        GetProfileError(message: failure.message),
      ),
      (profile) => emit(
        GetProfileSuccess(profileEntity: profile),
      ),
    );
  }
}

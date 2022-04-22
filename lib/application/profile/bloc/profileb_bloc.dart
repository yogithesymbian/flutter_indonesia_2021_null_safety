import 'package:bloc/bloc.dart';
import 'package:flutter_indonesia_2021/domain/core/user/model/user_response.dart';
import 'package:flutter_indonesia_2021/infrastructure/profile/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profileb_event.dart';
part 'profileb_state.dart';
part 'profileb_bloc.freezed.dart';

class ProfilebBloc extends Bloc<ProfilebEvent, ProfilebState> {
  ProfileRepository _profileRepository = ProfileRepository();
  ProfilebBloc() : super(_Initial()) {
    on<ProfilebEvent>((event, emit) async {
      await event.maybeMap(
        orElse: () {},
        getAllUser: (value) async {
          emit(ProfilebState.isLoading());
          final _result = await _profileRepository.getAllUserData();
          _result.fold(
            (l) => emit(ProfilebState.isError(l)),
            (r) => emit(ProfilebState.isSuccess(r)),
          );
        },
      );
    });
  }
}

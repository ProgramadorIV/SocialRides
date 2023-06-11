import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:proyecto_final_front/services/user_service.dart';

import '../../model/user/user_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    userService = GetIt.I.get<UserService>();
    on<ProfileFetched>(
      _onProfileFetched
    );
  }


  late final UserService userService;

  Future<void> _onProfileFetched(ProfileFetched event, Emitter<ProfileState> emit) async{
    try{
      final userProfile = await userService.getMyProfile();
      return emit(ProfileState(user: userProfile, status: ProfileStatus.sucess));
    }catch(_){
      emit(ProfileState(status: ProfileStatus.failure));
    }
  }
}

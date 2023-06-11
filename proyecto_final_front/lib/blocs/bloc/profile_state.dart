part of 'profile_bloc.dart';

enum ProfileStatus {initial, sucess, failure}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user = null,
  });

  final ProfileStatus status;
  final UserProfile? user;
  
  @override
  List<Object> get props => [];
}

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/config/locator.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/model/user/change_password_request.dart';
import 'package:proyecto_final_front/model/user/edit_user_request.dart';
import 'package:proyecto_final_front/model/user/user_details.dart';
import 'package:proyecto_final_front/model/user/user_list_response.dart';
import 'package:proyecto_final_front/model/user/user_profile.dart';
import 'package:proyecto_final_front/repositories/repositories.dart';

@singleton
class UserService {
  
  late UserRepository _userRepository;

  UserService(){
    _userRepository = GetIt.I.get<UserRepository>();
  }

  Future<PostResponse> getLikedPosts(int page) async {
    return _userRepository.fectchFavoritePosts(page);
  }

  Future<UserDetails> changePassword(ChangePasswordRequest request) async {
    return _userRepository.changePassword(request);
  }

  Future<UserProfile> getUserProfile(String username) async {
    return _userRepository.getUserProfile(username);
  }

  Future<UserProfile> getMyProfile() async {
    return _userRepository.getMyProfile();
  }

  Future<UserDetails> editUser(EditUserRequest request) async {
    return _userRepository.editUser(request);
  }

  Future<UserListResponse> filterUsers(int page, String searchQuery) async {
    return _userRepository.filterUsers(page, searchQuery);
  }

  Future<PostResponse> getLoggedUserPosts(int page) async {
    return _userRepository.getLoggedUserPosts(page);
  }
}
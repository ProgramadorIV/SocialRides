

import 'dart:convert';

import 'package:proyecto_final_front/config/locator.dart';
import 'package:proyecto_final_front/model/login.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/model/user/change_password_request.dart';
import 'package:proyecto_final_front/model/user/edit_user_request.dart';
import 'package:proyecto_final_front/model/user/user.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/model/user/user_details.dart';
import 'package:proyecto_final_front/model/user/user_list_response.dart';
import 'package:proyecto_final_front/model/user/user_profile.dart';

import 'package:proyecto_final_front/rest/rest.dart';

@Order(-1)
@singleton
class UserRepository {

  late RestAuthenticatedClient _authenticatedClient;
  late RestClient _client;

  UserRepository() {
    _authenticatedClient = getIt<RestAuthenticatedClient>();
    _client = getIt<RestClient>();
  }

  Future<dynamic> me() async {
    String url = "/me";

    var jsonResponse = await _authenticatedClient.get(url);
    return UserResponse.fromJson(jsonDecode(jsonResponse));

  }
  Future<PostResponse> fectchFavoritePosts(int page) async {
    String url = "/auth/user/like";

    return PostResponse.fromJson(jsonDecode(await _authenticatedClient.get(url)));
  }

  Future<UserDetails> changePassword(ChangePasswordRequest request) async {
    String url = "/auth/user/changePassword";

    return UserDetails.fromJson(jsonDecode(await _authenticatedClient.post(url, request)));
  }

  Future<UserProfile> getUserProfile(String username) async {
    String url = "/user/${username}";

    return UserProfile.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<UserProfile> getMyProfile() async {
    String url = "/auth/user/profile";

    return UserProfile.fromJson(jsonDecode(await _authenticatedClient.get(url)));
  }

  Future<UserDetails> editUser(EditUserRequest request) async {
    String url = "/auth/user/edit";

    return UserDetails.fromJson(jsonDecode(await _authenticatedClient.put(url, request)));
  }

  Future<UserListResponse> filterUsers(int page, String searchQuery) async {
    String url = "/user/filter?page=${page}&\$=${searchQuery}";

    return UserListResponse.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<PostResponse> getLoggedUserPosts(int page) async {
    String url = "/auth/post?page=${page}";

    return PostResponse.fromJson(jsonDecode(await _authenticatedClient.get(url)));
  }

}
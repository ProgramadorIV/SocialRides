
import 'package:json_annotation/json_annotation.dart';

part 'user_list_response.g.dart';

@JsonSerializable()
class UserListResponse {

  late final List<ListedUser>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final bool first;
  late final int currentPage;

  UserListResponse();
  factory UserListResponse.fromJson(Map<String, dynamic> json) => _$UserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}

@JsonSerializable()
class ListedUser {
  late final String username;
  late final String avatar;
  late final String name;
  late final String surname;

  ListedUser();

  factory ListedUser.fromJson(Map<String, dynamic> json) => _$ListedUserFromJson(json);
  Map<String, dynamic> toJson() => _$ListedUserToJson(this);
}
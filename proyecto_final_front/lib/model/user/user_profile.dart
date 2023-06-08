
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {

  late final String username;
  late final String avatar;
  late final String name;
  late final String surname;
  late final String birthday;
  late final String email;
  late final String createdAt;
  late final int posts;

  UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);  
}
import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  
  late final String id;
  late final String username;
  late final String avatar;
  late final String name;
  late final String surname;
  late final String email;
  late final String createdAt;

  UserDetails();

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
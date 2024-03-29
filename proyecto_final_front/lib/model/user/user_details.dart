import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  
  late final String avatar;
  late final String name;
  late final String surname;
  late final String birthday;
  late final String email;

  UserDetails();

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
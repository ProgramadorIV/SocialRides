// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails()
  ..avatar = json['avatar'] as String
  ..name = json['name'] as String
  ..surname = json['surname'] as String
  ..birthday = json['birthday'] as String
  ..email = json['email'] as String;

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'name': instance.name,
      'surname': instance.surname,
      'birthday': instance.birthday,
      'email': instance.email,
    };

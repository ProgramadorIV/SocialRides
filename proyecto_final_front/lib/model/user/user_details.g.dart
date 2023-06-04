// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails()
  ..id = json['id'] as String
  ..username = json['username'] as String
  ..avatar = json['avatar'] as String
  ..name = json['name'] as String
  ..surname = json['surname'] as String
  ..email = json['email'] as String
  ..createdAt = json['createdAt'] as String;

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'createdAt': instance.createdAt,
    };

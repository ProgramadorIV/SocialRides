// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile()
  ..username = json['username'] as String
  ..avatar = json['avatar'] as String
  ..name = json['name'] as String
  ..surname = json['surname'] as String
  ..birthday = json['birthday'] as String
  ..email = json['email'] as String
  ..createdAt = json['createdAt'] as String
  ..posts = json['posts'] as int;

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'username': instance.username,
      'avatar': instance.avatar,
      'name': instance.name,
      'surname': instance.surname,
      'birthday': instance.birthday,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'posts': instance.posts,
    };

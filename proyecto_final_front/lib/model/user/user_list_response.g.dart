// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse()
      ..content = (json['content'] as List<dynamic>?)
          ?.map((e) => ListedUser.fromJson(e as Map<String, dynamic>))
          .toList()
      ..last = json['last'] as bool
      ..totalPages = json['totalPages'] as int
      ..totalElements = json['totalElements'] as int
      ..first = json['first'] as bool
      ..currentPage = json['currentPage'] as int;

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'currentPage': instance.currentPage,
    };

ListedUser _$ListedUserFromJson(Map<String, dynamic> json) => ListedUser()
  ..username = json['username'] as String
  ..avatar = json['avatar'] as String
  ..name = json['name'] as String
  ..surname = json['surname'] as String;

Map<String, dynamic> _$ListedUserToJson(ListedUser instance) =>
    <String, dynamic>{
      'username': instance.username,
      'avatar': instance.avatar,
      'name': instance.name,
      'surname': instance.surname,
    };

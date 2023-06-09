// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse()
      ..id = json['id'] as String
      ..username = json['username'] as String
      ..avatar = json['avatar'] as String
      ..name = json['name'] as String
      ..surname = json['surname'] as String
      ..createdAt = json['createdAt'] as String;

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'name': instance.name,
      'surname': instance.surname,
      'createdAt': instance.createdAt,
    };

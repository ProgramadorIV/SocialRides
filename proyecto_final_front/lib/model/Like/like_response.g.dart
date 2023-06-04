// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeResponse _$LikeResponseFromJson(Map<String, dynamic> json) => LikeResponse()
  ..content = (json['content'] as List<dynamic>?)
      ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
      .toList()
  ..last = json['last'] as bool
  ..totalPages = json['totalPages'] as int
  ..totalElements = json['totalElements'] as int
  ..first = json['first'] as bool
  ..currentPage = json['currentPage'] as int;

Map<String, dynamic> _$LikeResponseToJson(LikeResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'currentPage': instance.currentPage,
    };

Like _$LikeFromJson(Map<String, dynamic> json) => Like()
  ..username = json['username'] as String
  ..dateTime = json['dateTime'] as String;

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'username': instance.username,
      'dateTime': instance.dateTime,
    };

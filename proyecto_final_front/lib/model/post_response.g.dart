// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse()
  ..content = (json['content'] as List<dynamic>?)
      ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
      .toList()
  ..last = json['last'] as bool
  ..totalPages = json['totalPages'] as int
  ..totalElements = json['totalElements'] as int
  ..first = json['first'] as bool
  ..currentPage = json['currentPage'] as int;

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'currentPage': instance.currentPage,
    };

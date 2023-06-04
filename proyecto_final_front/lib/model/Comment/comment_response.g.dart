// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse()
      ..content = (json['content'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..last = json['last'] as bool
      ..totalPages = json['totalPages'] as int
      ..totalElements = json['totalElements'] as int
      ..first = json['first'] as bool
      ..currentPage = json['currentPage'] as int;

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'currentPage': instance.currentPage,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment()
  ..username = json['username'] as String
  ..dateTime = json['dateTime'] as String
  ..body = json['body'] as String;

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'username': instance.username,
      'dateTime': instance.dateTime,
      'body': instance.body,
    };

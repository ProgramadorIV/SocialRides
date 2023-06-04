// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatWithMessagesResponse _$ChatWithMessagesResponseFromJson(
        Map<String, dynamic> json) =>
    ChatWithMessagesResponse()
      ..content = (json['content'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList()
      ..last = json['last'] as bool
      ..totalPages = json['totalPages'] as int
      ..totalElements = json['totalElements'] as int
      ..first = json['first'] as bool
      ..currentPage = json['currentPage'] as int;

Map<String, dynamic> _$ChatWithMessagesResponseToJson(
        ChatWithMessagesResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'currentPage': instance.currentPage,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message()
  ..id = json['id'] as int
  ..ownMessage = json['ownMessage'] as bool
  ..username = json['username'] as String
  ..body = json['body'] as String
  ..avatar = json['avatar'] as String
  ..dateTime = json['dateTime'] as String
  ..watched = json['watched'] as bool;

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'ownMessage': instance.ownMessage,
      'username': instance.username,
      'body': instance.body,
      'avatar': instance.avatar,
      'dateTime': instance.dateTime,
      'watched': instance.watched,
    };

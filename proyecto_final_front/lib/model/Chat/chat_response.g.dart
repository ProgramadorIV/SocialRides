// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse()
  ..content = (json['content'] as List<dynamic>?)
      ?.map((e) => Chat.fromJson(e as Map<String, dynamic>))
      .toList()
  ..last = json['last'] as bool
  ..totalPages = json['totalPages'] as int
  ..totalElements = json['totalElements'] as int
  ..first = json['first'] as bool
  ..currentPage = json['currentPage'] as int;

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'currentPage': instance.currentPage,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat()
  ..id = ChatId.fromJson(json['id'] as Map<String, dynamic>)
  ..avatar = json['avatar'] as String
  ..username = json['username'] as String
  ..lastUpdate = json['lastUpdate'] as String
  ..lastMessage = json['lastMessage'] as String;

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'username': instance.username,
      'lastUpdate': instance.lastUpdate,
      'lastMessage': instance.lastMessage,
    };

ChatId _$ChatIdFromJson(Map<String, dynamic> json) => ChatId()
  ..ownerId = json['ownerId'] as String
  ..recieverId = json['recieverId'] as String;

Map<String, dynamic> _$ChatIdToJson(ChatId instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'recieverId': instance.recieverId,
    };

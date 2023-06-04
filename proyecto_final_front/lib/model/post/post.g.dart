// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..id = json['id'] as int
  ..title = json['title'] as String
  ..img = json['img'] as String?
  ..description = json['description'] as String?
  ..location = json['location'] as String
  ..dateTime = json['dateTime'] as String;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'img': instance.img,
      'description': instance.description,
      'location': instance.location,
      'dateTime': instance.dateTime,
    };

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) => PostDetails()
  ..title = json['title'] as String
  ..img = json['img'] as String?
  ..description = json['description'] as String?
  ..location = json['location'] as String
  ..dateTime = json['dateTime'] as String
  ..username = json['username'] as String
  ..likes = (json['likes'] as List<dynamic>)
      .map((e) => Like.fromJson(e as Map<String, dynamic>))
      .toList()
  ..comments = (json['comments'] as List<dynamic>)
      .map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'img': instance.img,
      'description': instance.description,
      'location': instance.location,
      'dateTime': instance.dateTime,
      'username': instance.username,
      'likes': instance.likes,
      'comments': instance.comments,
    };

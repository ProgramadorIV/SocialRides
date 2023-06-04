import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_front/model/Comment/comment_response.dart';
import 'package:proyecto_final_front/model/Like/like_response.dart';

part 'post.g.dart';

/*class MyJsonConverter extends JsonConverter<Long, String> {

  const MyJsonConverter();
  @override
  Long fromJson(String json) {
    
    return json[1] as Long;
  }

  @override
  String toJson(Long object) {
    // TODO: implement toJson
    return object as String;
  }
}*/


@JsonSerializable()
class Post extends Equatable {
  //@MyJsonConverter()
  late final int id;
  late final String title;
  late final String? img;
  late final String? description;
  late final String location;
  late final String dateTime;

  Post();
  
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class PostDetails extends Equatable{

  late final String title;
  late final String? img;
  late final String? description;
  late final String location;
  late final String dateTime;
  late final String username;
  late final List<Like> likes;
  late final List<Comment> comments;

  PostDetails();

  @override
  // TODO: implement props
  List<Object?> get props => [username, dateTime];

  factory PostDetails.fromJson(Map<String, dynamic> json) => _$PostDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);
}
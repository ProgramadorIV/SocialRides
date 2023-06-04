import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_front/model/models.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  late final List<Comment>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final bool first;
  late final int currentPage;

  CommentResponse();

  factory CommentResponse.fromJson(Map<String, dynamic> json) => _$CommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

@JsonSerializable()
class Comment extends Equatable{
  late final String username;
  late final String dateTime;
  late final String body;
  
  Comment();
  @override
  List<Object?> get props => [username, dateTime, body];

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
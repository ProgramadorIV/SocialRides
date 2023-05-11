
import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_front/model/post.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  late final List<Post>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final int size;
  late final bool first;
  late final int numberOfElements;
  late final int number;

  PostResponse();

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
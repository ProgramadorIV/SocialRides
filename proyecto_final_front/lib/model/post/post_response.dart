
import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_front/model/post/post.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  late final List<Post>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final bool first;
  late final int currentPage;

  PostResponse();

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
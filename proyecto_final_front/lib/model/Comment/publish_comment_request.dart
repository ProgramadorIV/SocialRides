import 'package:json_annotation/json_annotation.dart';

part 'publish_comment_request.g.dart';

@JsonSerializable()
class PublishCommentRequest {

  late final String body;

  PublishCommentRequest();
  
  factory PublishCommentRequest.fromJson(Map<String, dynamic> json) => _$PublishCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PublishCommentRequestToJson(this);
}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publish_post_request.g.dart';

@JsonSerializable()
class PostRequest{
  late final String title;
  late final String description;
  late final String location;

  PostRequest(String title,String description,String location){
    this.title = title;
    this.description = description;
    this.location = location;
  }

  factory PostRequest.fromJson(Map<String, dynamic> json) => _$PostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostRequestToJson(this);


}
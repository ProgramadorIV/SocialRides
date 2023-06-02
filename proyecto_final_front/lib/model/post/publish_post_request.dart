import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../publish_post_request.g.dart';

@JsonSerializable()
class PostRequest extends Equatable {
  late final String title;
  late final String description;
  late final String location;

  PostRequest(String title,String description,String location){
    this.title = title;
    this.description = description;
    this.location = location;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [title, description, location];

  factory PostRequest.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}
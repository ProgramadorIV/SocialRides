import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_front/model/models.dart';

part 'like_response.g.dart';

@JsonSerializable()
class LikeResponse {
  late final List<Like>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final bool first;
  late final int currentPage;

  LikeResponse();

  factory LikeResponse.fromJson(Map<String, dynamic> json) => _$LikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LikeResponseToJson(this);

}

@JsonSerializable()
class Like extends Equatable{
  late final String username;
  late final String dateTime;
  
  Like();
  @override
  // TODO: implement props
  List<Object?> get props => [username, dateTime];

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
  Map<String, dynamic> toJson() => _$LikeToJson(this);
}
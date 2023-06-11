
import 'package:json_annotation/json_annotation.dart';

part 'exists_user.g.dart';

@JsonSerializable()
class ExistsUserResponse {
  late final bool exists;

  ExistsUserResponse();

  factory ExistsUserResponse.fromJson(Map<String, dynamic> json) => _$ExistsUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExistsUserResponseToJson(this);
}
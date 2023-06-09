
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {

  late final String id;
  late final String username;
  late final String avatar;
  late final String name;
  late final String surname;
  late final String createdAt;
  
  RegisterResponse();

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
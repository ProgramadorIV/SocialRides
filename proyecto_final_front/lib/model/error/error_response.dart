import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  late final String status;
  late final String message;
  late final String path;
  late final int statusCode;
  late final String date;
  late final List<SubError> subErrors;

  ErrorResponse();

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

@JsonSerializable()
class SubError {
  late final String object;
  late final String message;
  late final String field;

  SubError();

  factory SubError.fromJson(Map<String, dynamic> json) => _$SubErrorFromJson(json);
  Map<String, dynamic> toJson() => _$SubErrorToJson(this);
}
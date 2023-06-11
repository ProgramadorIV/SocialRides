// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..path = json['path'] as String
      ..statusCode = json['statusCode'] as int
      ..date = json['date'] as String
      ..subErrors = (json['subErrors'] as List<dynamic>)
          .map((e) => SubError.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'path': instance.path,
      'statusCode': instance.statusCode,
      'date': instance.date,
      'subErrors': instance.subErrors,
    };

SubError _$SubErrorFromJson(Map<String, dynamic> json) => SubError()
  ..object = json['object'] as String
  ..message = json['message'] as String
  ..field = json['field'] as String;

Map<String, dynamic> _$SubErrorToJson(SubError instance) => <String, dynamic>{
      'object': instance.object,
      'message': instance.message,
      'field': instance.field,
    };

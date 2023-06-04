import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_messages_response.g.dart';

@JsonSerializable()
class ChatWithMessagesResponse {
  late final List<Message>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final bool first;
  late final int currentPage;

  ChatWithMessagesResponse();

  factory ChatWithMessagesResponse.fromJson(Map<String, dynamic> json) => _$ChatWithMessagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatWithMessagesResponseToJson(this);
}
@JsonSerializable()
class Message extends Equatable {
  late final int id;
  late final bool ownMessage;
  late final String username;
  late final String body;
  late final String avatar;
  late final String dateTime;
  late final bool watched;

  Message();
  
  @override
  List<Object?> get props => [id];

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
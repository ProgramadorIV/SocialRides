import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  
  late final List<Chat>? content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final bool first;
  late final int currentPage;

  ChatResponse();

  factory ChatResponse.fromJson(Map<String, dynamic> json) => _$ChatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}

@JsonSerializable()
class Chat extends Equatable{
  late final ChatId id;
  late final String avatar;
  late final String username;
  late final String lastUpdate;
  late final String lastMessage;

  Chat();

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
  
  @override
  List<Object?> get props => [id];

}

@JsonSerializable()
class ChatId {
  late final String ownerId;
  late final String recieverId;

  ChatId();

  factory ChatId.fromJson(Map<String, dynamic> json) => _$ChatIdFromJson(json);
  Map<String, dynamic> toJson() => _$ChatIdToJson(this);
  
}
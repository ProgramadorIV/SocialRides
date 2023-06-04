import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/model/Chat/chat_messages_response.dart';
import 'package:proyecto_final_front/model/Chat/chat_response.dart';
import 'package:proyecto_final_front/model/Chat/send_message_request.dart';
import 'package:proyecto_final_front/repositories/post_repository.dart';
import 'package:proyecto_final_front/rest/rest.dart';

@singleton
class ChatRepository {
  late RestClient _client;
  late RestAuthenticatedClient _authenticatedClient;

  ChatRepository(){
    _client = GetIt.I.get<RestClient>();
    _authenticatedClient = GetIt.I.get<RestAuthenticatedClient>();
  }

  Future<ChatResponse> getMyChats(int page) async {
    String url = "/auth/chats?page=${page}";

    return ChatResponse.fromJson(jsonDecode(await _authenticatedClient.get(url)));
  }

  Future<ChatWithMessagesResponse> getChatByUsername(String username, int page) async {
    String url = "/auth/chats/${username}?page=${page}";

    return ChatWithMessagesResponse.fromJson(jsonDecode(await _authenticatedClient.get(url)));
  }
  Future<ChatWithMessagesResponse> sendMessage(String username, SendMessageRequest messageRequest) async {
    String url = "/auth/chats/${username}/sendMessage";

    return ChatWithMessagesResponse.fromJson(jsonDecode(await _authenticatedClient.post(url, messageRequest)));
  }
  Future<void> deleteMessage(String username, int idMessage) async {
    String url = "auth/chats/${username}/message/${idMessage}";

    await _authenticatedClient.delete(url);
  }
}
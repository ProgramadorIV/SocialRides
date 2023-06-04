import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/model/Chat/chat_messages_response.dart';
import 'package:proyecto_final_front/model/Chat/chat_response.dart';
import 'package:proyecto_final_front/model/Chat/send_message_request.dart';
import 'package:proyecto_final_front/repositories/chat_repository.dart';

@singleton
class ChatService {
  late ChatRepository _chatRepository;

  ChatService(){
    _chatRepository = GetIt.I.get<ChatRepository>();
  }

  Future<ChatResponse> getMyChats(int page) async {
    return _chatRepository.getMyChats(page);
  }

  Future<ChatWithMessagesResponse> getChatByUsername(String username, int page) async {
    return _chatRepository.getChatByUsername(username, page);
  }

  Future<ChatWithMessagesResponse> sendMessage(String username, SendMessageRequest messageRequest) async {
    return _chatRepository.sendMessage(username, messageRequest);
  }

  Future<void> deleteMessage(String username, int idMessage) async {
    return _chatRepository.deleteMessage(username, idMessage);
  }
  
}
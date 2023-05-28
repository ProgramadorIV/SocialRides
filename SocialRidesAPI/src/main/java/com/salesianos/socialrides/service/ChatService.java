package com.salesianos.socialrides.service;

import com.salesianos.socialrides.exception.chat.NoChatsFoundException;
import com.salesianos.socialrides.exception.user.UserNotFoundException;
import com.salesianos.socialrides.model.chat.Chat;
import com.salesianos.socialrides.model.chat.ChatPk;
import com.salesianos.socialrides.model.chat.dto.ChatResponse;
import com.salesianos.socialrides.model.message.Message;
import com.salesianos.socialrides.model.message.dto.MessageResponse;
import com.salesianos.socialrides.model.message.dto.SendMessageRequest;
import com.salesianos.socialrides.model.page.dto.PageResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.repository.ChatRepository;
import com.salesianos.socialrides.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityNotFoundException;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ChatService {

    private final ChatRepository chatRepository;
    private final MessageRepository messageRepository;

    private final UserService userService;

    public PageResponse<ChatResponse> getMyChats(Pageable pageable, UUID idUser){

        Page<ChatResponse> page = chatRepository.findMyChats(pageable, idUser);
        if(page.isEmpty())
            throw new NoChatsFoundException();

        return new PageResponse<>(page.map(chatResponse -> {
            chatResponse.setLastMessage(
                    messageRepository.findFirstMessageFromChat(
                            //PageRequest.of(0, 1, Sort.by("dateTime").descending()),
                            chatResponse.getId()
                    ));
            return chatResponse;
        }));

    }

    public PageResponse<MessageResponse> getMessagesInChat(Pageable pageable, String username, UUID userId){
        //TODO: SETEAR EL BOOLEANO DE WATCHED A TRUE SI NO ERES OWNER

        if(userService.existsByUsername(username))
            return new PageResponse<>(
                    messageRepository.findMessagesInChat(pageable, userId, username.toLowerCase())
                            .map(messageResponse -> {
                                watchMessages(messageResponse);
                                return messageResponse;
                            })
            );

        throw new UserNotFoundException(username);
    }

    @Transactional
    public void watchMessages(MessageResponse messageResponse){
        if(!messageResponse.isOwnMessage()){
            messageRepository.watchMessage(messageResponse.getId());
        }
    }

    public PageResponse<MessageResponse> sendMessage(
            Pageable pageable,
            String username,
            SendMessageRequest messageRequest,
            User currentUser){

        User user = userService.findByUsername(username)
                .orElseThrow(() -> new UserNotFoundException(username));
        ChatPk chatPk = new ChatPk(user.getId(), currentUser.getId());
        Optional<Chat> chat = chatRepository.findChatByUsers(user.getId(), currentUser.getId());

        if(chat.isEmpty()){
            Chat newChat = chatRepository.save(
                    Chat.builder()
                            .chatPk(chatPk)
                            .user1(user)
                            .user2(currentUser)
                            .build()
            );
            messageRepository.save(
                    Message.builder()
                            .body(messageRequest.getBody())
                            .owner(currentUser)
                            .chat(newChat)
                            .build()
            );
        } else{
            messageRepository.save(
                    Message.builder()
                            .body(messageRequest.getBody())
                            .owner(currentUser)
                            .chat(chat.get())
                            .build()
            );
            chat.get().setLastUpdate(LocalDateTime.now());
            chatRepository.save(chat.get());
        }
        return new PageResponse<MessageResponse>(
                messageRepository.findMessagesInChat(pageable, currentUser.getId(), username.toLowerCase())
        );
    }


}

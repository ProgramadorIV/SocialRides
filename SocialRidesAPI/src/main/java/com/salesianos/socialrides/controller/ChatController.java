package com.salesianos.socialrides.controller;

import com.salesianos.socialrides.model.chat.dto.ChatResponse;
import com.salesianos.socialrides.model.message.dto.MessageResponse;
import com.salesianos.socialrides.model.message.dto.SendMessageRequest;
import com.salesianos.socialrides.model.page.dto.PageResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.service.ChatService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.persistence.OrderBy;
import javax.validation.Valid;
import java.net.URI;

@RestController
@RequiredArgsConstructor
@Tag(name = "Chat", description = "Chat endpoints controller")
public class ChatController {

    private final ChatService chatService;

    @GetMapping("/auth/chats")
    public PageResponse<ChatResponse> getMyChats(
            @AuthenticationPrincipal User user,
            @PageableDefault(sort = "lastUpdate", direction = Sort.Direction.DESC)
            Pageable pageable) {
        return chatService.getMyChats(pageable, user.getId());
    }

    @PostMapping("/auth/chats/{username}/sendMessage")
    public ResponseEntity<PageResponse<MessageResponse>> sendMessage(
            @AuthenticationPrincipal User user,
            @PathVariable("username") String username,
            @Valid @RequestBody SendMessageRequest messageRequest,
            @PageableDefault(size = 20, sort = "dateTime", direction = Sort.Direction.DESC)
            Pageable pageable){
        PageResponse<MessageResponse> pagedMessages =
                chatService.sendMessage(pageable, username, messageRequest, user);
        URI uri = ServletUriComponentsBuilder
                .fromPath("/auth/chats/{username}")
                .buildAndExpand(username)
                .toUri();
        return ResponseEntity.created(uri).body(pagedMessages);
    }

    @GetMapping("/auth/chats/{username}")
    public PageResponse<MessageResponse> getMessagesFromChat(
            @AuthenticationPrincipal User user,
            @PathVariable("username") String username,
            @PageableDefault(size = 20, sort = "dateTime", direction = Sort.Direction.DESC)
            Pageable pageable){
        return chatService.getMessagesInChat(pageable, username, user.getId());

    }

}

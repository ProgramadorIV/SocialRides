package com.salesianos.socialrides.model.chat.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianos.socialrides.model.chat.ChatPk;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatResponse {

    //TODO MIRAR LO DE CHATPK
    public ChatResponse(ChatPk id,
                        String avatar,
                        String username,
                        LocalDateTime dateTime){
        this.id = id;
        this.avatar = avatar;
        this.username = username;
        this.lastUpdate = dateTime;
    }

    private ChatPk id;
    private String avatar;

    private String username;

    @JsonFormat(pattern = "dd/MM/yyyy hh:mm:ss")
    private LocalDateTime lastUpdate;


    private String lastMessage;
}

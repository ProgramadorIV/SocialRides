package com.salesianos.socialrides.model.message.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageResponse {

    public MessageResponse(
            Long id, String username, String body,
            String avatar, LocalDateTime dateTime,
            boolean watched, boolean ownMessage){
        this.id = id;
        this.ownMessage = ownMessage;
        this.username = username;
        this.body = body;
        this.avatar = avatar;
        this.dateTime = dateTime;
        this.watched = watched;
    }
    private Long id;

    private boolean ownMessage;

    private String username;

    private String body;

    private String avatar;

    @JsonFormat(pattern = "dd/MM/yyyy hh:mm:ss")
    private LocalDateTime dateTime;

    private boolean watched;
}

package com.salesianos.socialrides.model.chat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.UUID;

@Embeddable
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChatPk implements Serializable {

    private UUID ownerId;

    private UUID receiverId;
}

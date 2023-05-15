package com.salesianos.socialrides.model.message;

import com.salesianos.socialrides.model.chat.Chat;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.UUID;

@Entity
@Table(name = "message_entity")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Message {

    @Id
    @GeneratedValue
    private Long id;

    private UUID user;

    private String body;

    private boolean isWatched;

    private LocalDateTime dateTime;

    @ManyToOne
    @JoinColumn(name = "chat_id", foreignKey = @ForeignKey(
            name = "FK_MESSAGE_CHAT"
    ))
    private Chat chat;

    // TODO ************ HELPERS ******************

    public void addToChat(Chat c){
        chat = c;
        c.getMessages().add(this);
    }

    public void removeFromChat(Chat c){
        c.getMessages().remove(this);
        chat = null;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Message message = (Message) o;
        return Objects.equals(id, message.id);
    }
}

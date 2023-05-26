package com.salesianos.socialrides.model.message;

import com.salesianos.socialrides.model.chat.Chat;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "message_entity")
@EntityListeners(AuditingEntityListener.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private User owner;

    private String body;

    private boolean watched;

    @Builder.Default
    private LocalDateTime dateTime = LocalDateTime.now();
    @ManyToOne
    private Chat chat;


    //********* HELPERS *******************

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

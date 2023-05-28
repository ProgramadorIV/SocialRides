package com.salesianos.socialrides.model.chat;

import com.salesianos.socialrides.model.message.Message;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.user.User;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "chat_entity")
@EntityListeners(AuditingEntityListener.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Chat {

    @EmbeddedId
    private ChatPk chatPk = new ChatPk();

    @MapsId("ownerId")
    @ManyToOne
    @JoinColumn(name = "user2_id", foreignKey = @ForeignKey(name = "FK_CHAT_OWNER"), columnDefinition = "uuid")
    private User user2;

    @MapsId("receiverId")
    @ManyToOne
    @JoinColumn(name = "user1_id", foreignKey = @ForeignKey(name = "FK_CHAT_RECEIVER"), columnDefinition = "uuid")
    private User user1;

    @Builder.Default
    private LocalDateTime lastUpdate = LocalDateTime.now();

    @OneToMany(mappedBy = "chat", fetch = FetchType.LAZY)
    @Builder.Default
    @ToString.Exclude
    private Set<Message> messages = new HashSet<>();

    //********** HELPERS ************

    public void addToUser(User u){

    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Chat chat = (Chat) o;
        return Objects.equals(chatPk, chat.chatPk);
    }
}

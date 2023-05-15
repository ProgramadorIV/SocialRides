package com.salesianos.socialrides.model.chat;

import com.salesianos.socialrides.model.message.Message;
import com.salesianos.socialrides.model.user.User;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name = "chat_entity")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Chat {

    @Id
    @GeneratedValue
    private Long id;

    private String title;

    @ManyToMany(mappedBy = "chats")
    @Builder.Default
    private Set<User> users = new HashSet<>();

    private LocalDateTime lastUpdated;

    @OneToMany(mappedBy = "chat", fetch = FetchType.LAZY, orphanRemoval = true)
    private List<Message> messages = new ArrayList<>();


    // TODO ************ HELPERS ******************

    /*public void addToUser(User u){

    }*/

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Chat chat = (Chat) o;
        return Objects.equals(id, chat.id);
    }

}

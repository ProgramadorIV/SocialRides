package com.salesianos.socialrides.model.comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.UUID;

@Embeddable
@NoArgsConstructor
@Data
public class CommentPk implements Serializable {

    public CommentPk(UUID userId, Long postId){
        this.postId = postId;
        this.userId = userId;
    }
    private UUID userId;
    @Id
    private Long postId;

    private Long id;
}

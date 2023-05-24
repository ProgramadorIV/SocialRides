package com.salesianos.socialrides.repository;

import com.salesianos.socialrides.model.comment.Comment;
import com.salesianos.socialrides.model.comment.dto.CommentResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface CommentRepository extends JpaRepository<Comment, Long>, JpaSpecificationExecutor<Comment> {

    @Query("""
            SELECT new com.salesianos.socialrides.model.comment.dto.CommentResponse(
            c.id, c.user.username, c.dateTime, c.user.avatar, c.body)
            FROM Comment c
            WHERE c.post.id = :id
            """)
    Page<CommentResponse>findAllByPost(Pageable pageable, Long id);

    @Query("""
            SELECT COUNT(c)>0
            FROM Comment c LEFT JOIN FETCH Post p ON p.id = c.post
            LEFT JOIN FETCH User u ON u.id = p.user
            WHERE c.id = :idComment AND p.id = :idPost AND u.id = :idUser
            """)
    boolean existsCommentInPost(@Param("idComment") Long idComment,
                                @Param("idPost") Long idPost,
                                @Param("idUser") UUID idUser);

}

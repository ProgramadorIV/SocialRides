package com.salesianos.socialrides.repository;

import com.salesianos.socialrides.model.comment.Comment;
import com.salesianos.socialrides.model.comment.CommentPk;
import com.salesianos.socialrides.model.comment.dto.CommentResponse;
import com.salesianos.socialrides.model.like.Likee;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface CommentRepository extends JpaRepository<Comment, CommentPk>, JpaSpecificationExecutor<Comment> {

    @Query("""
            SELECT new com.salesianos.socialrides.model.comment.dto.CommentResponse(
            c.user.username, c.dateTime, c.user.avatar, c.body)
            FROM Comment c
            WHERE c.post.id = :id
            """)
    Page<CommentResponse>findAllByPost(Pageable pageable, Long id);
}

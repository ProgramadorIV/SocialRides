package com.salesianos.socialrides.repository;

import com.salesianos.socialrides.model.like.Likee;
import com.salesianos.socialrides.model.like.LikePk;
import com.salesianos.socialrides.model.like.dto.LikeResponse;
import com.salesianos.socialrides.model.post.Post;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface LikeRepository extends JpaRepository<Likee, LikePk>, JpaSpecificationExecutor<Likee> {

    @Query("""
            SELECT new com.salesianos.socialrides.model.like.dto.LikeResponse(
            l.user.username, l.user.avatar)
            FROM Likee l
            WHERE l.post.id = :id
            """)
    Page<LikeResponse> findAllByPost(Pageable pageable, Long id);
}

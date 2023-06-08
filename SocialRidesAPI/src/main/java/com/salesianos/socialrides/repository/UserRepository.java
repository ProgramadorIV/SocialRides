package com.salesianos.socialrides.repository;

import com.salesianos.socialrides.model.chat.Chat;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.model.user.dto.ListedUserResponse;
import com.salesianos.socialrides.model.user.dto.UserResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID>, JpaSpecificationExecutor<User> {

    @EntityGraph(value = "user-with-posts", type = EntityGraph.EntityGraphType.LOAD)
    Optional<User> findFirstByUsername(String username);

    Optional<User> findFirstByUsernameIgnoreCase(String username);

    boolean existsByUsernameIgnoreCase(String username);

    boolean existsByEmailIgnoreCase(String email);

    @EntityGraph(value = "user-with-posts-and-likes", type = EntityGraph.EntityGraphType.LOAD)
    Optional<User> findById(UUID id);

    Optional<User> findByUsername(String username);

    @Query("""
            SELECT DISTINCT new com.salesianos.socialrides.model.post.dto.PostResponse(
            p.id, p.title, p.description, p.img, p.location, p.dateTime)
            FROM Post p LEFT JOIN FETCH Likee l ON p.id = l.post.id
            WHERE l.user.id = :id
            """)
    Page<List<PostResponse>> findLikedPosts(Pageable pageable, UUID id);

    @Query("""
            SELECT new com.salesianos.socialrides.model.user.dto.UserResponse(
            avatar, username, name, username)
            FROM User
            """)
    Page<List<UserResponse>> findUsersFiltered(Pageable pageable, Specification<User> spec);

    @Query("""
            SELECT new com.salesianos.socialrides.model.user.dto.UserResponse(
            avatar, username, name, username)
            FROM User
            """)
    Page<UserResponse> findUsersFiltered(Pageable pageable);

}

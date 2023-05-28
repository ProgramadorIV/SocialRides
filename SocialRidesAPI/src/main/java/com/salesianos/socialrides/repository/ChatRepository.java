package com.salesianos.socialrides.repository;

import com.salesianos.socialrides.model.chat.Chat;
import com.salesianos.socialrides.model.chat.ChatPk;
import com.salesianos.socialrides.model.chat.dto.ChatResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface ChatRepository extends JpaRepository<Chat, ChatPk>, JpaSpecificationExecutor<Chat> {

    @Query("""
            SELECT DISTINCT new com.salesianos.socialrides.model.chat.dto.ChatResponse(
            c.id,
            CASE WHEN (c.user1.id = :idUser)
                THEN c.user2.avatar ELSE c.user1.avatar
            END,
            CASE WHEN (c.user1.id = :idUser)
                THEN c.user2.username ELSE c.user1.username
            END,
            c.lastUpdate
            )
            FROM Chat c LEFT JOIN FETCH Message m ON c.id = m.chat.id
            WHERE c.user1.id = :idUser OR c.user2.id = :idUser
            """)
    Page<ChatResponse> findMyChats(Pageable pageable, @Param("idUser") UUID idUser);


    @Query("""
            SELECT c
            FROM Chat c
            WHERE (c.user1.id = :userId OR c.user2.id = :userId)
                AND (c.user1.id = :currentUserId OR c.user2.id = :currentUserId)
            """)
    Optional<Chat> findChatByUsers(@Param("userId") UUID userId, UUID currentUserId);





}

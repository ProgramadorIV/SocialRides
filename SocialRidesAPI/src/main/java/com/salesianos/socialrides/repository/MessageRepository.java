package com.salesianos.socialrides.repository;

import com.salesianos.socialrides.model.chat.ChatPk;
import com.salesianos.socialrides.model.message.Message;
import com.salesianos.socialrides.model.message.dto.MessageResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

public interface MessageRepository extends JpaRepository<Message, Long>, JpaSpecificationExecutor<Message> {
    @Query(value = """
            SELECT m.body
            FROM Message m
            WHERE m.chat.id = :idChat
            ORDER BY m.dateTime DESC
            """)
    List<String> findFirstMessageFromChat(@Param("idChat") ChatPk idChat);

    @Query("""
            SELECT DISTINCT new com.salesianos.socialrides.model.message.dto.MessageResponse(
            m.id, m.owner.username, m.body, m.owner.avatar, m.dateTime, m.watched,
            CASE WHEN (m.owner.id = :userId)
                THEN true ELSE false
            END
            )
            FROM Message m
            WHERE (m.chat.user1.id = :userId AND LOWER(m.chat.user2.username) LIKE :username)
                OR
                (m.chat.user2.id = :userId AND LOWER(m.chat.user1.username) LIKE :username)
            """)
    Page<MessageResponse> findMessagesInChat(
            Pageable pageable,
            @Param("userId") UUID userId,
            @Param("username") String username);

    @Transactional
    @Modifying
    @Query("""
            UPDATE Message m SET m.watched = true WHERE m.id = :id
            """)
    void watchMessage(Long id);

    @Query("""
            SELECT COUNT(m)>0
            FROM Message m LEFT JOIN FETCH Chat c ON c.id = m.chat.id
            WHERE m.owner.id = :userId
                AND m.id = :messageId
                AND ((c.user1.id = :userId AND c.user2.id = :otherUserId)
                OR
                (c.user2.id = :userId AND c.user1.id = :otherUserId))
            """)
    boolean userOwnsMessage(
            @Param("userId") UUID userId,
            @Param("otherUserId")UUID otherUserId,
            @Param("messageId") Long messageId);
}

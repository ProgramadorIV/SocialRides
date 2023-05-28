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

import java.util.UUID;

public interface MessageRepository extends JpaRepository<Message, Long>, JpaSpecificationExecutor<Message> {

    @Query("""
            SELECT m.body
            FROM Message m
            WHERE m.chat.id = :idChat AND ROWNUM = 1
            ORDER BY m.dateTime DESC
            """)
    String findFirstMessageFromChat(@Param("idChat") ChatPk chatPk);
    //TODO: NO ME TRAE EL ULTIMO SI AÑADO MÁS MENSAJES

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
}

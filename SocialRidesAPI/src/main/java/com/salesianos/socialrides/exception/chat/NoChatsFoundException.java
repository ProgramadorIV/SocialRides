package com.salesianos.socialrides.exception.chat;

import javax.persistence.EntityNotFoundException;
import java.util.UUID;

public class NoChatsFoundException extends EntityNotFoundException {

    public NoChatsFoundException(){super("This user has no chats yet.");}
}

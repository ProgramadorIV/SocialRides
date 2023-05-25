package com.salesianos.socialrides.exception.comment;

import javax.persistence.EntityNotFoundException;

public class NoSuchCommentInPostException extends EntityNotFoundException {

    public  NoSuchCommentInPostException(Long idPost, Long idComment){super(String.format("" +
            "Comment with id: "+idComment+" not found in provided post: "+idPost));}
}

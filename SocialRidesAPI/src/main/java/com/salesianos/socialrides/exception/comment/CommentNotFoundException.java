package com.salesianos.socialrides.exception.comment;

import javax.persistence.EntityNotFoundException;

public class CommentNotFoundException extends EntityNotFoundException {

    public CommentNotFoundException(Long id){super(String.format("No comment with id: "+id));}
}

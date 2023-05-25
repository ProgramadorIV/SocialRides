package com.salesianos.socialrides.exception.like;

import com.salesianos.socialrides.model.like.LikePk;

import javax.persistence.EntityNotFoundException;

public class LikeNotFoundException extends EntityNotFoundException {

    public LikeNotFoundException(LikePk likePk){
        super("No like related with the data provided." +
            "\n- Post: "+likePk.getPostId()+"" +
            "\n- User: "+likePk.getUserId());
    }
}

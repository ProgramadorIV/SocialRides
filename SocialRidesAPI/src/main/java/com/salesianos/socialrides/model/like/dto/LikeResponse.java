package com.salesianos.socialrides.model.like.dto;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianos.socialrides.model.like.Likee;
import com.salesianos.socialrides.view.View;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeResponse {

    public LikeResponse(String username, String avatar){
        this.username = username;
        this.avatar = avatar;
    }

    @JsonView({View.PostView.PostWithEverythingView.class, View.LikesView.class})
    private String username;

    @JsonFormat(pattern = "dd/MM/yyyy hh:mm:ss")
    @JsonView({View.PostView.PostWithEverythingView.class})
    private LocalDateTime dateTime;

    @JsonView(View.LikesView.class)
    private String avatar;

    public static LikeResponse of(Likee likee){
        return LikeResponse.builder()
                .dateTime(likee.getDateTime())
                .username(likee.getUser().getUsername())
                .build();
    }




}

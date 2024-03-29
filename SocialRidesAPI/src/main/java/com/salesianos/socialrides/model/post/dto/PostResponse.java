package com.salesianos.socialrides.model.post.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianos.socialrides.model.comment.dto.CommentResponse;
import com.salesianos.socialrides.model.like.dto.LikeResponse;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.view.View;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostResponse {

    public PostResponse(Long id, String title, String description, String img, String location, LocalDateTime dateTime){
        this.id = id;
        this.title = title;
        this.description = description;
        this.img = img;
        this.location = location;
        this.dateTime = dateTime;
    }

    @JsonView({View.PostView.PostListView.class,
            View.UserView.ProfileView.class,
            View.PostView.ListAdminView.class
    })
    private Long id;

    @JsonView({View.PostView.PostWithEverythingView.class,
            View.PostView.PostListView.class,
            View.UserView.ProfileView.class,
            View.PostView.ListAdminView.class,
            View.PostView.ItemAdminView.class
    })
    private String title;

    @JsonView({View.PostView.PostWithEverythingView.class,
            View.PostView.PostListView.class,
            View.UserView.ProfileView.class,
            View.PostView.ItemAdminView.class})
    private String description;

    @JsonView({View.PostView.PostWithEverythingView.class,
            View.PostView.PostListView.class,
            View.UserView.ProfileView.class,
            View.PostView.ItemAdminView.class})
    private String img;

    @JsonView({View.PostView.PostWithEverythingView.class,
            View.PostView.PostListView.class,
            View.UserView.ProfileView.class,
            View.PostView.ListAdminView.class,
            View.PostView.ItemAdminView.class})
    private String location;

    @JsonFormat(pattern = "dd/MM/yyyy hh:mm:ss")
    @JsonView({View.PostView.PostWithEverythingView.class,
            View.PostView.PostListView.class,
            View.UserView.ProfileView.class,
            View.PostView.ListAdminView.class,
            View.PostView.ItemAdminView.class})
    private LocalDateTime dateTime;

    @JsonView({View.PostView.PostWithEverythingView.class,
            View.PostView.ListAdminView.class,
            View.PostView.ItemAdminView.class})
    private String username;

    @JsonView({View.PostView.ListAdminView.class})
    private int totalLikes;

    @JsonView({View.PostView.ListAdminView.class})
    private int totalComments;

    @JsonView({View.PostView.PostWithEverythingView.class})
    private List<LikeResponse> likes = new ArrayList<>();

    @JsonView({View.PostView.PostWithEverythingView.class})
    private List<CommentResponse> comments = new ArrayList<>();


    public static PostResponse of (Post post){
        return PostResponse.builder()
                //Puede que necesite el ternario en el img
                .username(post.getUser().getUsername())
                .title(post.getTitle())
                .description(post.getDescription()==null ? "" : post.getDescription())
                .img(post.getImg())
                .location(post.getLocation())
                .dateTime(post.getDateTime())
                .likes(
                        post.getLikes().stream().map(LikeResponse::of).toList()
                )
                .comments(
                        post.getComments().stream().map(CommentResponse::of).toList()
                )
                .build();
    }

    public static PostResponse fromUser(Post post){
        return PostResponse.builder()
                .id(post.getId())
                .title(post.getTitle())
                .description(post.getDescription()==null? "": post.getDescription())
                .img(post.getImg())
                .location(post.getLocation())
                .dateTime(post.getDateTime())
                .build();
    }

    public static PostResponse toAdminList(Post post){
        return PostResponse.builder()
                .id(post.getId())
                .title(post.getTitle())
                .location(post.getLocation())
                .username(post.getUser().getUsername())
                .dateTime(post.getDateTime())
                .totalLikes(post.getLikes().size())
                .totalComments(post.getComments().size())
                .build();
    }

    public static PostResponse toAdminItem(Post post){
        return PostResponse.builder()
                .username(post.getUser().getUsername())
                .title(post.getTitle())
                .description(post.getDescription() == null ? "": post.getDescription())
                .img(post.getImg())
                .location(post.getLocation())
                .dateTime(post.getDateTime())
                .build();
    }
}

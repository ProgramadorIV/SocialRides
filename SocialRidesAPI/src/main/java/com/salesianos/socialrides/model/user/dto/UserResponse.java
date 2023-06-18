package com.salesianos.socialrides.model.user.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.model.user.UserRole;
import com.salesianos.socialrides.security.jwt.refresh.RefreshToken;
import com.salesianos.socialrides.view.View;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class UserResponse {

    public UserResponse(String avatar, String username, String name, String surname){
        this.avatar = avatar;
        this.username = username;
        this.name = name;
        this.surname = surname;
    }
    @JsonView({View.UserView.CreatedView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListAdminView.class
    })
    protected String id;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.CreatedView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListView.class,
            View.UserView.ListAdminView.class
    })
    protected String username;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.CreatedView.class,
            View.UserView.DetailsView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListView.class,
            View.UserView.ListAdminView.class
    })
    protected String avatar;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.DetailsView.class,
            View.UserView.CreatedView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListView.class,
            View.UserView.ListAdminView.class
    })
    protected String name;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.DetailsView.class,
            View.UserView.CreatedView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListView.class,
            View.UserView.ListAdminView.class
    })
    protected String surname;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.DetailsView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListAdminView.class
    })
    protected LocalDate birthday;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.DetailsView.class,
            View.UserView.CreatedView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListAdminView.class
    })
    protected String email;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    @JsonView({View.UserView.ProfileView.class,
            View.UserView.CreatedView.class,
            View.UserView.LoggedView.class,
            View.UserView.ListAdminView.class
    })
    protected LocalDateTime createdAt;

    @JsonView({View.UserView.ListAdminView.class})
    protected boolean enabled;

    @JsonView({View.UserView.LoggedView.class})
    protected boolean admin;

    @JsonView({View.UserView.ProfileView.class,
            View.UserView.ListAdminView.class})
    protected Integer posts;

    /*@JsonView({View.UserView.ProfileView.class})
    protected List<PostResponse> posts;*/

    @JsonView(View.UserView.LoggedView.class)
    protected String token;

    @JsonView(View.UserView.LoggedView.class)
    protected String refreshToken;

    public static UserResponse toList(User user){
        return UserResponse.builder()
                .username(user.getUsername())
                .avatar(user.getAvatar() == null ? "" : user.getAvatar())
                .name(user.getName())
                .surname(user.getSurname())
                .build();
    }

    public static UserResponse toLoggedUser(User user, String token, String refreshToken){
        return UserResponse.builder()
                .id(user.getId().toString())
                .username(user.getUsername())
                .avatar(user.getAvatar() == null ? "" : user.getAvatar())
                .name(user.getName())
                .surname(user.getSurname())
                .birthday(user.getBirthday())
                .email(user.getEmail())
                .createdAt(user.getCreatedAt())
                .token(token)
                .refreshToken(token)
                .admin(user.getRoles().contains(UserRole.ADMIN))
                .build();
    }
    public static UserResponse toDetails(User user){
        return UserResponse.builder()
                .email(user.getEmail())
                .avatar(user.getAvatar() == null ? "" : user.getAvatar())
                .name(user.getName())
                .surname(user.getSurname())
                .birthday(user.getBirthday())
                .createdAt(user.getCreatedAt())
                .build();
    }

    public static UserResponse fromUser(User user){

        return UserResponse.builder()
                .id(user.getId().toString())
                .username(user.getUsername())
                .avatar(user.getAvatar() == null ? "" : user.getAvatar())
                .name(user.getName())
                .surname(user.getSurname())
                .email(user.getEmail())
                .createdAt(user.getCreatedAt())
                .build();
    }

    public static UserResponse of(User user){
        return UserResponse.builder()
                .username(user.getUsername())
                .avatar(user.getAvatar() == null ? "" : user.getAvatar())
                .name(user.getName())
                .surname(user.getSurname())
                .birthday(user.getBirthday())
                .email(user.getEmail())
                .createdAt(user.getCreatedAt())
                .posts(user.getPosts().size())
                .build();
    }

    public static UserResponse toListAdmin(User user){
        return UserResponse.builder()
                .id(user.getId().toString())
                .avatar(user.getAvatar() == null ? "" : user.getAvatar())
                .username(user.getUsername())
                .name(user.getName())
                .surname(user.getSurname())
                .email(user.getEmail())
                .birthday(user.getBirthday())
                .createdAt(user.getCreatedAt())
                .enabled(user.isEnabled())
                .posts(user.getPosts().size())
                .build();
    }
}

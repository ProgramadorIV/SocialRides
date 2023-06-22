package com.salesianos.socialrides.model.user.dto;

import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.model.user.UserRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.EnumSet;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoleResponse {

    private EnumSet<UserRole> roles;

    public static RoleResponse of(User u){
        return RoleResponse.builder()
                .roles(u.getRoles())
                .build();
    }
}

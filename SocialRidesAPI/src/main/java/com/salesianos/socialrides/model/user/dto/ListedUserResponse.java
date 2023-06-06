package com.salesianos.socialrides.model.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ListedUserResponse {

    private String username;
    private String avatar;
    private String name;
    private String surname;
}

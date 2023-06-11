package com.salesianos.socialrides.model.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ExistsUserResponse {

    private boolean exists;

    public static ExistsUserResponse of(boolean exists){
        return ExistsUserResponse.builder()
                .exists(exists)
                .build();
    }
}

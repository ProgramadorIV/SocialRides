package com.salesianos.socialrides.model.user.dto;

import com.salesianos.socialrides.model.user.UserRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import java.util.EnumSet;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EditRoleRequest {

    @NotEmpty
    EnumSet<UserRole> roles;
}

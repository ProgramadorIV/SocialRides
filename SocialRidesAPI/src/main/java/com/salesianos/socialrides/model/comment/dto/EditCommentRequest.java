package com.salesianos.socialrides.model.comment.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EditCommentRequest {

    @NotEmpty(message = "{commentRequest.body.notempty}")
    private String body;
}

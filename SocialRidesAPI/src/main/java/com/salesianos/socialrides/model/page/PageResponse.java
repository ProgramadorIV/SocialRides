package com.salesianos.socialrides.model.page;

import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.dto.UserResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class PageResponse<T> {

    protected int page;
    protected int numberOfElements;
    protected int totalPages;
    protected int size;
    protected List<T> content;

    /*public static PageResponse<> of(T any){

    }*/
}

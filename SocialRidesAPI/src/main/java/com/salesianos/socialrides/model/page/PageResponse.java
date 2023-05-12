package com.salesianos.socialrides.model.page;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.dto.UserResponse;
import com.salesianos.socialrides.view.View;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PageResponse<T> {

    @JsonView(View.PostView.PostListView.class)
    List<T> content;

    @JsonView(View.PostView.PostListView.class)
    int currentPage;

    @JsonView(View.PostView.PostListView.class)
    int totalPages;

    @JsonView(View.PostView.PostListView.class)
    int totalElements;

    @JsonView(View.PostView.PostListView.class)
    boolean last;

    @JsonView(View.PostView.PostListView.class)
    boolean first;

    public PageResponse (Page<T> page){
        this.content = page.getContent();
        this.currentPage = page.getNumber();
        this.totalPages = page.getTotalPages();
        this.totalElements = (int)page.getTotalElements();
        this.first = page.isFirst();
        this.last = page.isLast();

    }

}
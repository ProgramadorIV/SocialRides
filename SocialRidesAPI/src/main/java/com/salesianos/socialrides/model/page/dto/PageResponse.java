package com.salesianos.socialrides.model.page.dto;

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

    @JsonView({View.PostView.PostListView.class,
            View.LikesView.class,
            View.CommentsView.class
    })
    List<T> content;

    @JsonView({View.PostView.PostListView.class,
            View.LikesView.class,
            View.CommentsView.class
    })
    int currentPage;

    @JsonView({View.PostView.PostListView.class,
            View.LikesView.class,
            View.CommentsView.class
    })
    int totalPages;

    @JsonView({View.PostView.PostListView.class,
            View.LikesView.class,
            View.CommentsView.class
    })
    int totalElements;

    @JsonView({View.PostView.PostListView.class,
            View.LikesView.class,
            View.CommentsView.class
    })
    boolean last;

    @JsonView({View.PostView.PostListView.class,
            View.LikesView.class,
            View.CommentsView.class
    })
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
package com.salesianos.socialrides.service;

import com.salesianos.socialrides.exception.post.NoPostsException;
import com.salesianos.socialrides.exception.post.NoUserPostsException;
import com.salesianos.socialrides.exception.post.PostNotFoundException;
import com.salesianos.socialrides.exception.user.UserNotFoundException;
import com.salesianos.socialrides.files.service.StorageService;
import com.salesianos.socialrides.model.page.PageResponse;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.post.dto.CreatePostRequest;
import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.repository.PostRepository;
import com.salesianos.socialrides.search.spec.GenericSpecificationBuilder;
import com.salesianos.socialrides.search.util.SearchCriteria;
import com.salesianos.socialrides.search.util.SearchCriteriaExtractor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;

    private final UserService userService;

    private final StorageService storageService;

    public Post findById(Long id){
        return postRepository.findById(id).orElseThrow(() -> new PostNotFoundException(id));
    }

    /*public PostResponse findOne(Long id){
        return postRepository.findOne(id)
                .orElseThrow(() -> new PostNotFoundException(id));

    }*/

    public PageResponse<List<PostResponse>> findAllByUser(Pageable pageable, UUID id){

        PageResponse<List<PostResponse>> pageResponse = new PageResponse<>(postRepository.findAllByUser(pageable, id));

        if(pageResponse.getContent().isEmpty())
            throw new NoUserPostsException();

        return pageResponse;
    }

    public Post findPostWithInteractions(Long id){
        return postRepository.findPost(id).orElseThrow(() -> new PostNotFoundException(id));
    }

    public PostResponse createPost(CreatePostRequest newPost, MultipartFile file, User u){

        String filename = storageService.store(file);

        Post post = Post.builder()
                        .img(filename)
                        .title(newPost.getTitle())
                        .description(newPost.getDescription())
                        .location(newPost.getLocation())
                        .build();
        User user = userService.findById(u.getId())
                .orElseThrow(UserNotFoundException::new);
        post.addToUser(user);
        postRepository.save(post);

        return PostResponse.of(post);
    }

    public PageResponse<List<PostResponse>> findAll(String searchQuery, Pageable pageable){
        List<PostResponse> posts = List.of();
        List<SearchCriteria> searchCriteria = SearchCriteriaExtractor.extractSearchCriteriaList(searchQuery);
        Specification<Post> spec = (new GenericSpecificationBuilder<Post>(searchCriteria)).build();
        Page<PostResponse> page = postRepository.findAll(spec, pageable).map(PostResponse::fromUser);

        if (page.isEmpty())
            throw new NoPostsException();

        return new PageResponse(page);
    }

    public PostResponse editPost(Long id, CreatePostRequest editedPost, MultipartFile file){

        String filename = storageService.store(file);

        return PostResponse.of(postRepository.findById(id).map(post -> {
            post.setTitle(editedPost.getTitle());
            post.setImg(filename);
            post.setDescription(editedPost.getDescription());
            post.setLocation(editedPost.getLocation());
            return postRepository.save(post);
        }).orElseThrow(() -> new PostNotFoundException(id)));
    }

    public void deletePost(Long id){
        postRepository.deleteById(id);
    }
}

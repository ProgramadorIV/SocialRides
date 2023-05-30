package com.salesianos.socialrides.service;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianos.socialrides.exception.comment.CommentNotFoundException;
import com.salesianos.socialrides.exception.comment.NoSuchCommentInPostException;
import com.salesianos.socialrides.exception.post.NoPostsException;
import com.salesianos.socialrides.exception.post.NoUserPostsException;
import com.salesianos.socialrides.exception.post.PostNotFoundException;
import com.salesianos.socialrides.exception.user.UserNotFoundException;
import com.salesianos.socialrides.model.comment.Comment;
import com.salesianos.socialrides.model.comment.CommentPk;
import com.salesianos.socialrides.model.comment.dto.CommentRequest;
import com.salesianos.socialrides.model.comment.dto.CommentResponse;
import com.salesianos.socialrides.model.like.LikePk;
import com.salesianos.socialrides.model.like.Likee;
import com.salesianos.socialrides.model.like.dto.LikeResponse;
import com.salesianos.socialrides.model.page.dto.PageResponse;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.post.dto.CreatePostRequest;
import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.repository.CommentRepository;
import com.salesianos.socialrides.repository.LikeRepository;
import com.salesianos.socialrides.repository.PostRepository;
import com.salesianos.socialrides.search.spec.GenericSpecificationBuilder;
import com.salesianos.socialrides.search.util.SearchCriteria;
import com.salesianos.socialrides.search.util.SearchCriteriaExtractor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;

    private final UserService userService;

    private final StorageService storageService;
    private final LikeRepository likeRepository;
    private final CommentRepository commentRepository;

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
        Specification<Post> spec = (new GenericSpecificationBuilder<Post>(searchCriteria, Post.class)).build();
        if(spec != null){
            Page<PostResponse> page = postRepository.findAll(spec, pageable).map(PostResponse::fromUser);
            if (page.isEmpty())
                throw new NoPostsException();

            return new PageResponse(page);
        }
        return new PageResponse(postRepository.findAll(pageable).map(PostResponse::fromUser));
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
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException(id));

        postRepository.delete(post);
        //TODO storageService.deleteFile(post.getImg());
    }

    public PostResponse likePostInteraction(Long idPost, User user){
        Post post = postRepository.findById(idPost)
                .orElseThrow(() -> new PostNotFoundException(idPost));
        LikePk likePk = new LikePk(user.getId(), idPost);

        if(likeRepository.existsById(likePk)){
            likeRepository.delete(likeRepository.findById(likePk).orElseThrow());
        }else{
            Likee newLike = Likee.builder()
                        .likePk(likePk)
                        .post(post)
                        .user(user)
                        .build();
            likeRepository.save(newLike);
        }
        return PostResponse.of(post);
    }


    public PageResponse<LikeResponse> findPostLikes(Pageable pageable, Long idPost){
        Post post = postRepository.findById(idPost).orElseThrow(() -> new PostNotFoundException(idPost));
        return new PageResponse<>(likeRepository.findAllByPost(pageable, idPost));
    }

    public PageResponse<CommentResponse> findPostComments(Pageable pageable, Long idPost){
        Post post = postRepository.findById(idPost).orElseThrow(() -> new PostNotFoundException(idPost));
        return new PageResponse<>(commentRepository.findAllByPost(pageable, idPost));
    }


    public PageResponse<CommentResponse> createComment(Long idPost, CommentRequest newComment, User user, Pageable pageable){
        Post post = postRepository.findById(idPost).orElseThrow(()-> new PostNotFoundException(idPost));
        commentRepository.save(
                Comment.builder()
                        .body(newComment.getBody())
                        .user(user)
                        .post(post)
                        .build()
        );
        //Pageable pageable = PageRequest.of(1, 10, Sort.by("dateTime").descending());
        return new PageResponse<>(commentRepository.findAllByPost(pageable, idPost));
    }

    public void deleteComment(Long idPost, Long idComment, UUID idUser){

        Post post = postRepository.findById(idPost)
                .orElseThrow(()-> new PostNotFoundException(idPost));

        Comment comment = commentRepository.findById(idComment)
                        .orElseThrow(
                                ()->new CommentNotFoundException(idComment)
                        );
        if(commentRepository.existsCommentInPost(idComment, idPost, idUser))
            commentRepository.delete(comment);
        else
            throw new NoSuchCommentInPostException(idPost, idComment);
    }

    //TODO - SI EXISTE UN COMENTARIO DE UN USUARIO EN OTRO POST
    // E INDICAS ESE IDCOMMENT EN LA URL AUNQUE NO SEA DEL POST
    // LO BORRA Y ACTUALIZA.
    public PageResponse<CommentResponse> editComment(Long idPost,
                                                     Long idComment,
                                                     UUID idUser,
                                                     CommentRequest commentRequest,
                                                     Pageable pageable){
        Post post = postRepository.findById(idPost)
                .orElseThrow(()-> new PostNotFoundException(idPost));

        Comment comment = commentRepository.findById(idComment)
                .orElseThrow(()-> new CommentNotFoundException(idComment));

        if(commentRepository.existsCommentInPost(idComment, idPost, idUser)){
            comment.setBody(commentRequest.getBody());
            commentRepository.save(comment);
            return new PageResponse<>(commentRepository.findAllByPost(pageable, idPost));
        }

        throw new NoSuchCommentInPostException(idPost, idComment);
    }
}

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/model/Comment/comment_response.dart';
import 'package:proyecto_final_front/model/Comment/publish_comment_request.dart';
import 'package:proyecto_final_front/model/Like/like_response.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/model/post/publish_post_request.dart';
import 'package:proyecto_final_front/repositories/post_repository.dart';

@singleton
class PostService {
  late PostRepository _postRepository;

  PostService(){
    _postRepository = GetIt.I.get<PostRepository>();
  }

  Future<PostResponse> getAllPosts(int page, String searchQuery) async{
    return _postRepository.fetchPostPage(page, searchQuery);
  }

  Future<PostDetails> getDetailsById(int id) async {
    return _postRepository.getPostDetails(id);
  }
  
  Future<PostResponse> getPostFromUser(int page) async {
    return _postRepository.getPostFromUser(page);
  }
  
  Future<PostDetails> publishPost(PostRequest postRequest) async {
    return _postRepository.publishPost(postRequest);
  }

  Future<PostDetails> editPost(PostRequest editPostRequest, int idPost) async {
    return _postRepository.editPost(editPostRequest, idPost);

  }

  Future<void> deletePost(int idPost) async {
    return _postRepository.deletePost(idPost);
  }

  //////// INTERACTIONS 

  Future<PostDetails> likePost(int idPost, _) async {
    return _postRepository.likePost(idPost, _);
  }

  Future<LikeResponse> getLikesFromPost(int idPost, int page) async {
    return _postRepository.getLikesFromPost(idPost, page);
  }

  Future<CommentResponse> getCommentsFromPost(int page, int idPost) async {
    return _postRepository.getCommentsFromPost(page, idPost);
  }

  Future<CommentResponse> publishComment(int idPost, PublishCommentRequest commentRequest) async {
    return _postRepository.publishComment(idPost, commentRequest);
  }

  Future<CommentResponse> editComment(int idPost, int idComment, PublishCommentRequest commentRequest) async {
    return _postRepository.editComment(idPost, idComment, commentRequest);
  }

  Future<void> deleteComment(int idPost, int idComment) async {
    return _postRepository.deleteComment(idPost, idComment);
  }

  /* TODO Crear peticion de delete en el cliente autenticado */
  /*Future<void> deletePost(int idPost) async{
    String url = "/auth/post/${idPost}";

    await _authenticatedClient.delete(url);
  }*/
}
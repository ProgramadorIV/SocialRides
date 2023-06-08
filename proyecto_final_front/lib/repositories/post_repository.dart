import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/config/locator.dart';
import 'package:proyecto_final_front/model/Comment/comment_response.dart';
import 'package:proyecto_final_front/model/Comment/publish_comment_request.dart';
import 'package:proyecto_final_front/model/Like/like_response.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/model/post/publish_post_request.dart';
import 'package:proyecto_final_front/rest/rest.dart';

@singleton
class PostRepository {
  late RestClient _client;
  late RestAuthenticatedClient _authenticatedClient;

  PostRepository(){
    _client = GetIt.I.get<RestClient>();
    _authenticatedClient = GetIt.I.get<RestAuthenticatedClient>();
  }

  Future<PostResponse> fetchPostPage(int page, String searchQuery) async {
    String url = "/post/?page=${page}&\$=${searchQuery}";

    return PostResponse.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<PostDetails> getPostDetails(int id) async {
    String url = "/post/${id}";

    return PostDetails.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<PostResponse> getPostFromUser(int page) async {
    String url = "/auth/post?page=${page}";

    return PostResponse.fromJson(jsonDecode(await _authenticatedClient.get(url)));
  }

  Future<PostDetails> publishPost(PostRequest postRequest) async {
    String url = "/auth/post";

    return PostDetails.fromJson(jsonDecode(await _authenticatedClient.post(url, postRequest)));
  }

  Future<PostDetails> editPost(PostRequest editPostRequest, int idPost) async {
    String url = "/auth/post/${idPost}";

    return PostDetails.fromJson(jsonDecode(await _authenticatedClient.put(url, editPostRequest)));
  }

  Future<void> deletePost(int idPost) async{
    String url = "/auth/post/${idPost}";

    await _authenticatedClient.delete(url);
  }

  Future<PostDetails> likePost(int idPost, _) async {
    String url = "/auth/post/${idPost}/like";

    return PostDetails.fromJson(jsonDecode(await _authenticatedClient.put(url, _)));
  }

  Future<LikeResponse> getLikesFromPost(int idPost, int page) async {
    String url = "/post/${idPost}/likes?page=${page}";

    return LikeResponse.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<CommentResponse> getCommentsFromPost(int page, int idPost) async {
    String url = "/post/${idPost}/comments?page${page}";

    return CommentResponse.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<CommentResponse> publishComment(int idPost, PublishCommentRequest commentRequest) async {
    String url = "auth/post/${idPost}/comment";

    return CommentResponse.fromJson(jsonDecode(await _authenticatedClient.post(url, commentRequest)));
  }

  Future<CommentResponse> editComment(int idPost, int idComment, PublishCommentRequest commentRequest) async {
    String url = "auth/post/${idPost}/comment/${idComment}";

    return CommentResponse.fromJson(jsonDecode(await _authenticatedClient.put(url, commentRequest)));
  }

  Future<void> deleteComment(int idPost, int idComment) async {
    String url = "auth/post/${idPost}/comment/${idComment}";

    await _authenticatedClient.delete(url);
  }


  //TODO: HACER MODELO PARA PAGE QUE ACEPTE CUALQUIER OBJETO DENTRO.
  

  
}
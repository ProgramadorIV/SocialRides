import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/config/locator.dart';
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

  Future<PostResponse> fetchPostPage(int page) async {
    String url = "/post/?page=${page}"; //TODO: Posible inclusión de los parametros search.

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


  
}
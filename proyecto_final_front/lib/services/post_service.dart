import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/model/post/publish_post_request.dart';
import 'package:proyecto_final_front/repositories/post_repository.dart';

@singleton
class PostService {
  late PostRepository _postRepository;

  PostService(){
    _postRepository = GetIt.I.get<PostRepository>();
  }

  Future<PostResponse> getAllPosts(int page) async{
    return _postRepository.fetchPostPage(page); //Para hacer search -> "search=" en ()
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

  /* TODO Crear peticion de delete en el cliente autenticado */
  /*Future<void> deletePost(int idPost) async{
    String url = "/auth/post/${idPost}";

    await _authenticatedClient.delete(url);
  }*/
}
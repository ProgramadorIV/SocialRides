import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/model/models.dart';
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
}
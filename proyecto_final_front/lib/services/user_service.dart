import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/config/locator.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/repositories/repositories.dart';

@singleton
class UserService {
  
  late UserRepository _userRepository;

  UserService(){
    _userRepository = GetIt.I.get<UserRepository>();
  }

  Future<PostResponse> getLikedPosts(int page) async {
    return _userRepository.fectchFavoritePosts(page);
  }
}
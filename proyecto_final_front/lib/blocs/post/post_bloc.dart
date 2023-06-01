import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/repositories/post_repository.dart';
import 'package:proyecto_final_front/services/post_service.dart';
import 'package:proyecto_final_front/services/user_service.dart';
//import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';


part 'post_event.dart';
part 'post_state.dart';

//const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(/*{required this.httpClient}*/) : super(const PostState()) {
  //PostBloc({required this.repo}) : super(const PostState()) {
    repo = GetIt.I.get<PostRepository>();
    userService = GetIt.I.get<UserService>();
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<FavoritePostFetched>(
      _onFavoritePostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  
  late PostRepository repo;
  late UserService userService;

  Future<void> _onFavoritePostFetched(
    FavoritePostFetched event,
    Emitter<PostState> emit
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        //final posts = await _fetchPosts();
        final posts = await userService.getLikedPosts(0);
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts.content,
            hasReachedMax: posts.last,
            page: 0
          ),
        );
      }
      //final posts = await _fetchPosts(state.posts.length);
      final posts = await repo.fetchPostPage(state.page + 1);
      emit(
            state.copyWith(
            status: PostStatus.success,
            posts: List.of(state.posts)..addAll(posts.content!),
            hasReachedMax: posts.last,
            page: posts.currentPage
            ),
        );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
  

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        //final posts = await _fetchPosts();
        final posts = await repo.fetchPostPage(0);
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts.content,
            hasReachedMax: posts.last,
            page: 0
          ),
        );
      }
      //final posts = await _fetchPosts(state.posts.length);
      final posts = await repo.fetchPostPage(state.page + 1);
      emit(
            state.copyWith(
            status: PostStatus.success,
            posts: List.of(state.posts)..addAll(posts.content!),
            hasReachedMax: posts.last,
            page: posts.currentPage
            ),
        );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
  
}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/services/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_transform/stream_transform.dart';
part 'post_detail_event.dart';
part 'post_detail_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc() : super(PostDetailState()) {
    postService = GetIt.I.get<PostService>();
    on<PostDetailFetched>(_onPostDetailFetched);
  }

  late final PostService postService;

  Future<void> _onPostDetailFetched(
      PostDetailFetched event, Emitter<PostDetailState> emit) async {
    try {
      final postDetails = await postService.getDetailsById(event.id);
      return emit(PostDetailState(
          postDetails: postDetails, status: PostDetailStatus.success));
    } catch (_) {
      emit(PostDetailState(status: PostDetailStatus.failure));
    }
  }
}

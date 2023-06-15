part of 'post_detail_bloc.dart';

enum PostDetailStatus { initial, success, failure }

class PostDetailsState {}

class PostDetailState extends PostDetailsState {
  PostDetailState({
    this.status = PostDetailStatus.initial,
    this.postDetails = null,
  });

  final PostDetailStatus status;
  final PostDetails? postDetails;

  @override
  List<Object?> get props => [];
}

class PostActionState extends PostDetailsState {}

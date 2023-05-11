part of 'post_detail_bloc.dart';

abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object> get props => [];
}

class PostDetailFetched extends PostDetailEvent {
  PostDetailFetched(this.id);
  final int id;
}

class FavoriteEvent extends PostDetailEvent {}

class CommentEvent extends PostDetailEvent {}
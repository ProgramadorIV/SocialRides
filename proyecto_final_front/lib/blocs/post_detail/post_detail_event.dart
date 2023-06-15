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

class FavoriteEvent extends PostDetailEvent {
  FavoriteEvent(this.idPost);
  final int idPost;
}

class CommentEvent extends PostDetailEvent {
  CommentEvent(this.request, this.idPost);
  final PublishCommentRequest request;
  final int idPost;
}

class ShowLikesEvent extends PostDetailEvent {
  ShowLikesEvent(this.idPost, this.page);
  final int idPost;
  final int page;
}

class ShowCommentsEvent extends PostDetailEvent {
  ShowCommentsEvent(this.idPost, this.page);
  final int idPost;
  final int page;
}

class DeleteCommentEvent extends PostDetailEvent {
  DeleteCommentEvent(this.idPost, this.idComment);
  final int idPost;
  final int idComment;
}

class EditCommentEvent extends PostDetailEvent {
  EditCommentEvent(this.idPost, this.request);
  final int idPost;
  final PublishCommentRequest request;
}

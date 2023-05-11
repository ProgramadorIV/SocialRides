part of 'post_detail_bloc.dart';


enum PostDetailStatus {initial, success, failure}

class PostDetailState extends Equatable {

  const PostDetailState({
    this.status = PostDetailStatus.initial,
    this.postDetails = null,
  });

  final PostDetailStatus status;
  final PostDetails? postDetails;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}


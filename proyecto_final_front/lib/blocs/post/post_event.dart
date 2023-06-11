part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class FavoritePostFetched extends PostEvent {}

class UserPostFetched extends PostEvent {}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final_front/blocs/post/post_bloc.dart';
import 'package:proyecto_final_front/pages/post_list_page.dart';
import 'package:proyecto_final_front/widgets/post_list_item.dart';

class FavoritePage extends StatelessWidget{

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => PostBloc()..add(FavoritePostFetched()),
      child: Favorites(),
    );
  }
}

class Favorites extends StatefulWidget {
  const Favorites({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritesState();  
}

class _FavoritesState extends State<Favorites>{

  final _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? const Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      ),
                    )
                    : PostListItem(post: state.posts[index]);//PostListItem(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(FavoritePostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
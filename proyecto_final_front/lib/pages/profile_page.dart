import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final_front/blocs/bloc/profile_bloc.dart';
import 'package:proyecto_final_front/blocs/post/post_bloc.dart';
import 'package:proyecto_final_front/model/user/user_profile.dart';
import 'package:proyecto_final_front/pages/post_list_page.dart';
import 'package:proyecto_final_front/widgets/default_img.dart';
import 'package:proyecto_final_front/widgets/post_list_item.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileData(),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        Flexible(
          child: ProfileList(),
        )
      ],
    );
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileFetched()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state.status) {
            case ProfileStatus.failure:
              return const Center(
                child: Text('Failed to fetch user profile data.'),
              );
            case ProfileStatus.sucess:
              return _profileData(state, context);
            case ProfileStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  _profileData(ProfileState state, BuildContext context) {
    final UserProfile user = state.user ?? new UserProfile();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CircleAvatar(
                  backgroundImage: Image.network(
                    user.avatar != ''
                        ? "http://localhost:8080/download/" + user.avatar
                        : 'https://cdn-icons-png.flaticon.com/512/456/456212.png',
                    errorBuilder: (context, error, stackTrace) => DefaultImg(),
                    fit: BoxFit.cover,
                  ).image,
                  backgroundColor: Colors.grey.shade300,
                  radius: 25,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width / 1.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name + ' ' + user.surname,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '@' + user.username,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 10,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed:
                      () {}, //=> Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserPage())), //TODO:
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              //TODO: COMPLETAR DATOS DEL USUARIO
            ),
          )
        ],
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(UserPostFetched()),
      child: ProfilePostList(),
    );
  }
}

class ProfilePostList extends StatefulWidget {
  const ProfilePostList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePostListState();
}

class _ProfilePostListState extends State<ProfilePostList> {
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
                    : PostListItem(post: state.posts[index]);
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
    if (_isBottom) context.read<PostBloc>().add(UserPostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

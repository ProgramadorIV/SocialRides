import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_final_front/blocs/authentication/authentication.dart';
import 'package:proyecto_final_front/blocs/authentication/authentication_bloc.dart';
import 'package:proyecto_final_front/pages/favorites_pages.dart';
import 'package:proyecto_final_front/pages/home_page.dart';
import 'package:proyecto_final_front/pages/login_page.dart';
import 'package:proyecto_final_front/pages/post_list_page.dart';
import 'package:proyecto_final_front/pages/profile_page.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return listViews[index];
  }
}

List<Widget> listViews = [
      PostPage(),
      BlocBuilder<AuthenticationBloc, AuthenticationState>
      (builder: (context, state){
        if(state is AuthenticationAuthenticated){
          return FavoritePage();
        }
        if(state is AuthenticationNotAuthenticated){
          return LoginPage();
        }
        return CircularProgressIndicator();
      }),
      BlocBuilder<AuthenticationBloc, AuthenticationState>
      (builder: (context, state){
        if(state is AuthenticationAuthenticated){
          return Profilepage();
        }
        if(state is AuthenticationNotAuthenticated){
          return LoginPage();
        }
        return CircularProgressIndicator();
      }),
    ];
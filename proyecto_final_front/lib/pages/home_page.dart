import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_front/blocs/authentication/authentication.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/pages/login_page.dart';
import 'package:proyecto_final_front/routes/routes.dart';
import 'package:proyecto_final_front/widgets/bottom_navigator.dart';


class HomePage extends StatefulWidget{
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  } 
}
class _HomePageState extends State<HomePage>{

  int page = 0;
  BottomNavigator? bottomNavigator;
  
  @override
  void initState() {
    bottomNavigator = BottomNavigator(targetView: (index){
      setState(() {
        page = index;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
           IconButton(onPressed: (){
            authBloc.add(UserLoggedOut());
            }, 
            icon: Icon(Icons.logout),
            color: Colors.white,
            hoverColor: Colors.red,
            padding: EdgeInsets.all(10),
            )
        ],
        /*actions: [
          IconButton(
            onPressed: () async{
              if(logged){
                authBloc.add(UserLoggedOut());
                _userLoggedOut();
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }
            },
            icon: Icon(logged ? Icons.logout : Icons.login),
            color: Colors.white,
            hoverColor: Colors.teal,
            padding: EdgeInsets.all(10),
          ),
        ],*/
        backgroundColor: Colors.lightBlue,
        title: Text(
          'Social Rides',
          style: GoogleFonts.pacifico(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: bottomNavigator,
      body: Routes(index: page),
    );
  }
}

/*class HomePage extends StatelessWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user?.id== null ? 'bro' : user?.name}',
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                //textColor: Theme.of(context).primaryColor,
                /*style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),*/
                child: Text(user?.id == null ? 'LogIn': 'LogOut'),
                onPressed: (){
                  if(user?.id != null){
                    authBloc.add(UserLoggedOut());
                  }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
              ElevatedButton(onPressed: () async {
                print("Check");
                JwtAuthenticationService service = getIt<JwtAuthenticationService>();
                await service.getCurrentUser();
              }
              , child: Text('Check')
              )
            ],
          ),
        ),
      ),
    );
  }
}*/

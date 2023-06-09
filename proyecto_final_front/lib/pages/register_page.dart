import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_front/blocs/blocs.dart';
import 'package:proyecto_final_front/blocs/register/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 30, 30, 30),
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/originals/d1/3f/8a/d13f8a89424496e99d6dfc57809c153c.jpg'),
            repeat: ImageRepeat.repeat
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Center(
              child: Text('Social Rides', style: GoogleFonts.pacifico(color: Colors.white))
            ),
          ),
          body: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is AuthenticationAuthenticated){
                  return _AlreadyLogged();
                }
                else if(state is AuthenticationNotAuthenticated){
                  return _RegisterForm();
                }
                return Center(child: CircularProgressIndicator(strokeWidth: 2,),);
              },
            )
          )
        )
      )
    );
  }
}

class _AlreadyLogged extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(239, 255, 255, 255), 
          borderRadius: BorderRadius.circular(10),
        ),
        height: MediaQuery.of(context).size.height/3,
        width: MediaQuery.of(context).size.width/2,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Can not register if you are already logged with an account',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
          ],
        )
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(),
        child: _RegisterFormWidget(),
      ),
    );
  }
}

class _RegisterFormWidget extends StatefulWidget {
  const _RegisterFormWidget({super.key});

  @override
  State<_RegisterFormWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterFormWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Hola'),);
  }
}
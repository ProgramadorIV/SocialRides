import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_front/config/locator.dart';
import 'package:proyecto_final_front/pages/home_page.dart';
import 'package:proyecto_final_front/pages/register_page.dart';
import '../blocs/blocs.dart';
import '../services/services.dart';

class LoginPage extends StatelessWidget {
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
                  final authBloc = BlocProvider.of<AuthenticationBloc>(context);
                  if (state is AuthenticationNotAuthenticated) {
                    return _AuthForm();
                  }
                  if (state is AuthenticationFailure || state is SessionExpiredState) {
                    var msg = (state as AuthenticationFailure).message;
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(msg),
                        TextButton(
                          //textColor: Theme.of(context).primaryColor,
                          child: Text('Retry'),
                          onPressed: () {
                            authBloc.add(UserLoggedOut());
                          },
                        )
                      ],
                    ));
                  }
                  if(state is AuthenticationAuthenticated){
                    // Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: state.user)));
                  }
                  // return splash screen
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
              )
            ),
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authService = getIt<JwtAuthenticationService>();
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      if (_key.currentState!.validate()) {
        _loginBloc.add(LoginInWithEmailButtonPressed(email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(239, 255, 255, 255), 
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(right: 20, left: 20),
            height: MediaQuery.of(context).size.height/1.75,
            width: MediaQuery.of(context).size.width/1.5,
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Image(
                          image: NetworkImage("https://logomakercdn.truic.com/ux-flow/industry/skate-shop-meta.png"),
                          height: MediaQuery.of(context).size.width < 1200 ? 
                          MediaQuery.of(context).size.width/5 : 200
                        ),
                      ),
                        Text('Login', style: GoogleFonts.pacifico(
                          color: Colors.black, 
                          fontSize: MediaQuery.of(context).size.width < 1200 ? 
                          MediaQuery.of(context).size.width/15 : 100
                      ),)
                    ],
                  ),
                ),
                Form(
                  key: _key,
                  autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                            isDense: true,
                          ),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null) {
                              return 'Username is required.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            isDense: true,
                          ),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null) {
                              return 'Password is required.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //RaisedButton(
                        ElevatedButton(
                          //color: Theme.of(context).primaryColor,
                          //textColor: Colors.white,
                          //padding: const EdgeInsets.all(16),
                          //shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric( vertical: 10, horizontal: MediaQuery.of(context).size.width/10))
                          ),
                          child: Text('LOG IN'),
                          onPressed: state is LoginLoading ? () {} : _onLoginButtonPressed,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "No account?",
                                ),
                                TextSpan(
                                  text: " Click here",
                                  style: TextStyle(
                                    color: Colors.blue
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = 
                                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),))
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          );
        },
      ),
    );
  }

  void _showError(String error) {
    /*Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));*/

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));


  }
}

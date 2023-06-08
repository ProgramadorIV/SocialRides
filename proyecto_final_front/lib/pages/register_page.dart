import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: BlocBuilder<>(
              builder: (context, state) {
                if(state is )
              },
            )
          )
        )
      )
    );
  }

}
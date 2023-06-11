import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_front/blocs/blocs.dart';
import 'package:proyecto_final_front/blocs/register/register_bloc.dart';
import 'package:proyecto_final_front/model/error/error_response.dart';
import 'package:proyecto_final_front/model/user/exists_user.dart';
import 'package:proyecto_final_front/model/user/register_user_request.dart';
import 'package:proyecto_final_front/pages/login_page.dart';
import 'package:proyecto_final_front/services/user_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FormThemeProvider(
          theme: FormTheme(
            checkboxTheme: CheckboxFieldTheme(
              canTapItemTile: true,
            ),
            radioTheme: RadioFieldTheme(
              canTapItemTile: true,
            ),
          ),
          child: child!,
        );
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationAuthenticated){
                  return _AlreadyLogged();
                }
                else if(state is AuthenticationNotAuthenticated){
                  return RegisterForm();
                }
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 2,),
                );
        },
      ),
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
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Can not register if you are already logged with an account',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                    child: Text('Go back!'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            )
        )
    );
  }
}

class RegisterFormBloc extends FormBloc<String, String> {
  // final select1 = SelectFieldBloc(
  //   items: ['Option 1', 'Option 2'],
  //   validators: [FieldBlocValidators.required],
  // );

  // final select2 = SelectFieldBloc(
  //   items: ['Option 1', 'Option 2'],
  //   validators: [FieldBlocValidators.required],
  // );

  // final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
  //   items: [
  //     'Option 1',
  //     'Option 2',
  //     'Option 3',
  //     'Option 4',
  //     'Option 5',
  //   ],
  // );

  //final dateAndTime1 = InputFieldBloc<DateTime?, Object>(initialValue: null);

  //final time1 = InputFieldBloc<TimeOfDay?, Object>(initialValue: null);

  // final double1 = InputFieldBloc<double, dynamic>(
  //   initialValue: 0.5,
  // );
  final username = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ]
  );
  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ]
  );
  final verifyPassword = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ]
  );
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email
    ]
  );
  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ]
  );
  final surname = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ]
  );
  final birthday = InputFieldBloc<DateTime, Object>(
    initialValue: DateTime.now(),
    validators: [
      FieldBlocValidators.required,
    ]
  );
  final file = InputFieldBloc<File?, String>(
    initialValue: null,
    validators: [
      FieldBlocValidators.required,
    ]
  );

  RegisterFormBloc() {
    addFieldBlocs(fieldBlocs: [
      username,
      name,
      surname,
      email,
      password,
      verifyPassword,
      birthday,
      // file
    ]);

    verifyPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
    username.addAsyncValidators([_checkUsername]);

  }

  Future<String?> _checkUsername(String? username) async {
    UserService userService = GetIt.I.get<UserService>();
    if(username != null){
      ExistsUserResponse response = await userService.existsByUsername(username);
      if(response.exists)
        return 'That username is already taken';
      return null;
    }
    return null;
  }

  // static String? _passwordFriendly(TextFieldBloc password){
    
  //   final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,15}$');

  //   if(regex.hasMatch(password.value))
  //     return null;
  //   return 'The password must match classic format.';
  // }

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'Must be equal to password';
    };
  }

  @override
  void onSubmitting() async {
    //TODO IMPLEMENTAR LOGICA ANTES DE ENVIAR
    RegisterUserRequest request = RegisterUserRequest(
      username: username.value,
      password: password.value,
      verifyPassword: verifyPassword.value,
      name: name.value,
      surname: surname.value,
      birthday: DateFormat('dd/MM/yyyy').format(birthday.value),
      email: email.value
    );
    final UserService userService = GetIt.I.get<UserService>();
    try {
      final response = await userService.registerUser(request, /*file.value*/ new File('')); //TODO
      if(response.statusCode == 400){
        ErrorResponse error= ErrorResponse.fromJson(jsonDecode(response.body));
        error.subErrors.forEach((subError) {
          switch (subError.field) {
            case "username":
              username.addFieldError(subError.message.toString());
              break;
            case "password":
              password.addFieldError(subError.message.toString());
              break;
            case "verifyPassword":
              verifyPassword.addFieldError(subError.message.toString());
              break;
            case "name":
              name.addFieldError(subError.message.toString());
              break;
            case "surname":
              surname.addFieldError(subError.message.toString());
              break;
            case "email":
              email.addFieldError(subError.message.toString());
              break;
            case "email":
              email.addFieldError(subError.message.toString());
              break;
          }
        });
        
      await Future<void>.delayed(const Duration(seconds: 1));
      emitFailure(failureResponse: 'Bad data provided.');
      }
      else{
        await Future<void>.delayed(const Duration(seconds: 1));
        emitSuccess(successResponse: jsonEncode(response.body.toJson()));
      }
    } catch (e) {

      debugPrint(e.toString());
      await Future<void>.delayed(const Duration(seconds: 2));
      emitFailure(failureResponse: 'Unknown error.');
    }
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = context.read<RegisterFormBloc>();
          return Container(
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
                    child: Text('Social Rides', style: GoogleFonts.pacifico(color: Colors.white),)
                  )
                ),
                // floatingActionButton: Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     // FloatingActionButton.extended(
                //     //   heroTag: null,
                //     //   onPressed: formBloc.addErrors,
                //     //   icon: const Icon(Icons.error_outline),
                //     //   label: const Text('SHOW ERRORS'),
                //     // ),
                //     const SizedBox(height: 12),
                //     FloatingActionButton.extended(
                //       heroTag: null,
                //       onPressed: formBloc.submit,
                //       icon: const Icon(Icons.send),
                //       label: const Text('SUBMIT'),
                      
                //     ),
                //   ],
                // ),
                body: SafeArea(
                  minimum: const EdgeInsets.all(16),
                  child: FormBlocListener<RegisterFormBloc, String, String>(
                    onSubmitting: (context, state) {
                      LoadingDialog.show(context);
                    },
                    onSubmissionFailed: (context, state) {
                      LoadingDialog.hide(context);
                    },
                    onSuccess: (context, state) {
                      LoadingDialog.hide(context);
                        
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const SuccessScreen())); //TODO
                    },
                    onFailure: (context, state) {
                      LoadingDialog.hide(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.failureResponse!)));
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(239, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width / 1.5,
                        alignment: Alignment.center,
                        child: ScrollableFormBlocManager(
                          formBloc: formBloc,
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Already have an account?",

                                      ),
                                      TextSpan(
                                        text: " Click here",
                                        style: TextStyle(
                                          color: Colors.blue
                                        ),
                                        recognizer: TapGestureRecognizer()..onTap = 
                                        () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),))
                                      )
                                    ],
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.username,
                                  decoration: const InputDecoration(
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.name,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.surname,
                                  decoration: const InputDecoration(
                                    labelText: 'Surname',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.email,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.password,
                                  suffixButton: SuffixButton.obscureText,
                                  decoration: const InputDecoration(
                                    labelText: 'password',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                TextFieldBlocBuilder(
                                  textFieldBloc: formBloc.verifyPassword,
                                  suffixButton: SuffixButton.obscureText,
                                  decoration: const InputDecoration(
                                    labelText: 'Verify Password',
                                    prefixIcon: Icon(Icons.text_fields),
                                  ),
                                ),
                                DateTimeFieldBlocBuilder(
                                  dateTimeFieldBloc: formBloc.birthday,
                                  format: DateFormat('dd-MM-yyyy'),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  decoration: const InputDecoration(
                                    labelText: 'Birthday',
                                    prefixIcon: Icon(Icons.calendar_today),
                                    helperText: 'Choose your birthday',
                                  ),
                                ),
                                BlocBuilder<InputFieldBloc<File?, String>,
                                        InputFieldBlocState<File?, String>>(
                                    bloc: formBloc.file,
                                    builder: (context, state) {
                                      return Container();
                                    }), //TODO: 
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/3,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      alignment: Alignment.center
                                    ),
                                    onPressed: formBloc.submit,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.send),
                                        Text('SUBMIT'),
                                      ],
                                    ),
                                  ),
                                )
                                
                                // RadioButtonGroupFieldBlocBuilder<String>(
                                //   selectFieldBloc: formBloc.select2,
                                //   decoration: const InputDecoration(
                                //     labelText: 'RadioButtonGroupFieldBlocBuilder',
                                //   ),
                                //   groupStyle: const FlexGroupStyle(),
                                //   itemBuilder: (context, item) => FieldItem(
                                //     child: Text(item),
                                //   ),
                                // ),
                                // CheckboxGroupFieldBlocBuilder<String>(
                                //   multiSelectFieldBloc: formBloc.multiSelect1,
                                //   decoration: const InputDecoration(
                                //     labelText: 'CheckboxGroupFieldBlocBuilder',
                                //   ),
                                //   groupStyle: const ListGroupStyle(
                                //     scrollDirection: Axis.horizontal,
                                //     height: 64,
                                //   ),
                                //   itemBuilder: (context, item) => FieldItem(
                                //     child: Text(item),
                                //   ),
                                // ),
                                // DateTimeFieldBlocBuilder(
                                //   dateTimeFieldBloc: formBloc.dateAndTime1,
                                //   canSelectTime: true,
                                //   format: DateFormat('dd-MM-yyyy  hh:mm'),
                                //   initialDate: DateTime.now(),
                                //   firstDate: DateTime(1900),
                                //   lastDate: DateTime(2100),
                                //   decoration: const InputDecoration(
                                //     labelText: 'DateTimeFieldBlocBuilder',
                                //     prefixIcon: Icon(Icons.date_range),
                                //     helperText: 'Date and Time',
                                //   ),
                                // ),
                                // TimeFieldBlocBuilder(
                                //   timeFieldBloc: formBloc.time1,
                                //   format: DateFormat('hh:mm a'),
                                //   initialTime: TimeOfDay.now(),
                                //   decoration: const InputDecoration(
                                //     labelText: 'TimeFieldBlocBuilder',
                                //     prefixIcon: Icon(Icons.access_time),
                                //   ),
                                // ),
                                // SwitchFieldBlocBuilder(
                                //   booleanFieldBloc: formBloc.boolean2,
                                //   body: const Text('SwitchFieldBlocBuilder'),
                                // ),
                                // DropdownFieldBlocBuilder<String>(
                                //   selectFieldBloc: formBloc.select1,
                                //   decoration: const InputDecoration(
                                //     labelText: 'DropdownFieldBlocBuilder',
                                //   ),
                                //   itemBuilder: (context, value) => FieldItem(
                                //     isEnabled: value != 'Option 1',
                                //     child: Text(value),
                                //   ),
                                // ),
                                // Row(
                                //   children: [
                                //     IconButton(
                                //       onPressed: () => formBloc.addFieldBloc(
                                //           fieldBloc: formBloc.select1),
                                //       icon: const Icon(Icons.add),
                                //     ),
                                //     IconButton(
                                //       onPressed: () => formBloc.removeFieldBloc(
                                //           fieldBloc: formBloc.select1),
                                //       icon: const Icon(Icons.delete),
                                //     ),
                                //   ],
                                // ),
                                // CheckboxFieldBlocBuilder(
                                //   booleanFieldBloc: formBloc.boolean1,
                                //   body: const Text('CheckboxFieldBlocBuilder'),
                                // ),
                                // CheckboxFieldBlocBuilder(
                                //   booleanFieldBloc: formBloc.boolean1,
                                //   body: const Text('CheckboxFieldBlocBuilder trailing'),
                                //   controlAffinity:
                                //       FieldBlocBuilderControlAffinity.trailing,
                                // ),
                                // SliderFieldBlocBuilder(
                                //   inputFieldBloc: formBloc.double1,
                                //   divisions: 10,
                                //   labelBuilder: (context, value) =>
                                //       value.toStringAsFixed(2),
                                // ),
                                // SliderFieldBlocBuilder(
                                //   inputFieldBloc: formBloc.double1,
                                //   divisions: 10,
                                //   labelBuilder: (context, value) =>
                                //       value.toStringAsFixed(2),
                                //   activeColor: Colors.red,
                                //   inactiveColor: Colors.green,
                                // ),
                                // SliderFieldBlocBuilder(
                                //   inputFieldBloc: formBloc.double1,
                                //   divisions: 10,
                                //   labelBuilder: (context, value) =>
                                //       value.toStringAsFixed(2),
                                // ),
                                // ChoiceChipFieldBlocBuilder<String>(
                                //   selectFieldBloc: formBloc.select2,
                                //   itemBuilder: (context, value) => ChipFieldItem(
                                //     label: Text(value),
                                //   ),
                                // ),
                                // FilterChipFieldBlocBuilder<String>(
                                //   multiSelectFieldBloc: formBloc.multiSelect1,
                                //   itemBuilder: (context, value) => ChipFieldItem(
                                //     label: Text(value),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            const Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const RegisterPage())),
              icon: const Icon(Icons.replay),
              label: const Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}


// class _RegisterForm extends StatelessWidget {
//   const _RegisterForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: BlocProvider<RegisterBloc>(
//         create: (context) => RegisterBloc(),
//         child: _RegisterFormWidget(),
//       ),
//     );
//   }
// }

// class _RegisterFormWidget extends StatefulWidget {
//   const _RegisterFormWidget({super.key});

//   @override
//   State<_RegisterFormWidget> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<_RegisterFormWidget> {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('Hola'),
//     );
//   }
// }
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
  
}

class RegisterButtonPressed extends RegisterEvent {

  late final RegisterUserRequest request;

  RegisterButtonPressed(String birthday, email, name, password, verifyPassword, surname, username){
    this.request = RegisterUserRequest(
      username: username, 
      password: password, 
      verifyPassword: verifyPassword, 
      name: name, 
      surname: surname, 
      birthday: birthday, 
      email: email);
  }

  @override
  List<Object> get props => [request];
}


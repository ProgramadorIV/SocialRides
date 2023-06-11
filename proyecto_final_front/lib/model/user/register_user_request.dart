import 'package:json_annotation/json_annotation.dart';
class RegisterUserRequest {

  late String username;
  late String password;
  late String verifyPassword;
  late String email;
  late String name;
  late String surname;
  late String birthday;
  
  RegisterUserRequest({required this.username, required this.password, required this.verifyPassword, 
  required this.name, required this.surname, required this.birthday, required this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['verifyPassword'] = verifyPassword;
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['birthday'] = birthday;
    return data;
  }


}
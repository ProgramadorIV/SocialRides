
/*class User {
  final String name;
  final String email;
  final String accessToken;
  final String? avatar;

  User({required this.name, required this.email, required this.accessToken, this.avatar});

  @override
  String toString() => 'User { name: $name, email: $email}';
}*/


import 'package:proyecto_final_front/model/login.dart';

class User {
  String? id;
  String? username;
  String? avatar;
  String? name;
  String? surname;

  User({this.id, this.username, this.avatar, this.name, this.surname});

    User.fromLoginResponse(LoginResponse response) {
      this.id = response.id;
      this.username = response.username;
      this.avatar = response.avatar;
      this.name = response.name;
      this.surname = response.surname;
    }
}

class UserResponse extends User {

  UserResponse(id, username, name, avatar, surname) : super(id: id, username: username, name: name, avatar: avatar, surname: surname);

  UserResponse.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  username = json['username'];
  avatar = json['avatar'];
  name = json['name'];
  surname = json['surname'];
}
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['username'] = this.username;
  data['avatar'] = this.avatar;
  data['name'] = this.name;
  data['surname'] = this.surname;
  return data;
}

}

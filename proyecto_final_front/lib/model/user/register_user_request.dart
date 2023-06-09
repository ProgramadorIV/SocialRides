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
}
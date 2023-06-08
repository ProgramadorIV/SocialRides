class EditUserRequest {
  
  late String name;
  late String surname;
  late String email;
  late String birthday;

  EditUserRequest(String name, surname, email, birthday){
    this.birthday = birthday;
    this.email = email;
    this.name = name;
    this.surname = surname;
  }
}
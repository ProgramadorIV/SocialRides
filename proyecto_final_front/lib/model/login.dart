class LoginResponse {
  String? id;
  String? username;
  String? name;
  String? surname;
  String? createdAt;
  String? avatar;
  String? token;
  String? refreshToken;

  LoginResponse(
      {this.id,
      this.username,
      this.name,
      this.surname,
      this.createdAt,
      this.avatar,
      this.token,
      this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    surname = json['surname'];
    createdAt = json['createdAt'];
    avatar = json['avatar'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['surname'] = surname;
    data['token'] = token;
    data['avatar'] = avatar;
    data['refreshToken'] = refreshToken;
    return data;
  }
  
}


class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

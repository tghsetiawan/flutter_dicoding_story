class AuthModel {
  final String? username;
  final String? email;
  final String? password;

  AuthModel({
    this.username,
    this.email,
    this.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        username: json['id'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

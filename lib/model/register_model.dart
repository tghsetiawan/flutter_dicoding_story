class RegisterModel {
  final String? name;
  final String? email;
  final String? password;

  RegisterModel({
    this.name,
    this.email,
    this.password,
  });

  RegisterModel copyWith({
    String? name,
    String? email,
    String? password,
  }) =>
      RegisterModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}

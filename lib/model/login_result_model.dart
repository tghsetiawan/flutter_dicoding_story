class LoginResultt {
  final String? userId;
  final String? name;
  final String? token;

  LoginResultt({
    this.userId,
    this.name,
    this.token,
  });

  LoginResultt copyWith({
    String? userId,
    String? name,
    String? token,
  }) =>
      LoginResultt(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        token: token ?? this.token,
      );

  factory LoginResultt.fromJson(Map<String, dynamic> json) => LoginResultt(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };
}

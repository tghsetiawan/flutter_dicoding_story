class ResponseLoginModel {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  ResponseLoginModel({
    this.error,
    this.message,
    this.loginResult,
  });

  ResponseLoginModel copyWith({
    bool? error,
    String? message,
    LoginResult? loginResult,
  }) =>
      ResponseLoginModel(
        error: error ?? this.error,
        message: message ?? this.message,
        loginResult: loginResult ?? this.loginResult,
      );

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseLoginModel(
        error: json["error"],
        message: json["message"],
        loginResult: json["loginResult"] == null
            ? null
            : LoginResult.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult?.toJson(),
      };
}

class LoginResult {
  final String? userId;
  final String? name;
  final String? token;

  LoginResult({
    this.userId,
    this.name,
    this.token,
  });

  LoginResult copyWith({
    String? userId,
    String? name,
    String? token,
  }) =>
      LoginResult(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        token: token ?? this.token,
      );

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
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

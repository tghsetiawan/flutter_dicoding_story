class ResponseModel {
  final bool? error;
  final String? message;

  ResponseModel({
    this.error,
    this.message,
  });

  ResponseModel copyWith({
    bool? error,
    String? message,
  }) =>
      ResponseModel(
        error: error ?? this.error,
        message: message ?? this.message,
      );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}

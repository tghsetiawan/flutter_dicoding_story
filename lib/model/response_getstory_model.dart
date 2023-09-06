import 'dart:convert';

ResponseGetStory responseGetStoryFromJson(String str) =>
    ResponseGetStory.fromJson(json.decode(str));

String responseGetStoryToJson(ResponseGetStory data) =>
    json.encode(data.toJson());

class ResponseGetStory {
  final bool? error;
  final String? message;
  final List<ListStory>? listStory;

  ResponseGetStory({
    this.error,
    this.message,
    this.listStory,
  });

  factory ResponseGetStory.fromJson(Map<String, dynamic> json) =>
      ResponseGetStory(
        error: json["error"],
        message: json["message"],
        listStory: json["listStory"] == null
            ? []
            : List<ListStory>.from(
                json["listStory"]!.map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": listStory == null
            ? []
            : List<dynamic>.from(listStory!.map((x) => x.toJson())),
      };
}

class ListStory {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  ListStory({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}

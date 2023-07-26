import 'dart:io';
import 'dart:typed_data';

class AddStoryRequest {
  final String? description;
  final File? photo;
  final Float32List? lat;
  final Float32List? lon;

  AddStoryRequest({
    this.description,
    this.photo,
    this.lat,
    this.lon,
  });
}

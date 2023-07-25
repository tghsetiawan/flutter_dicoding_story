import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> selectImage() async {
  try {
    XFile? selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return selectedImage;
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

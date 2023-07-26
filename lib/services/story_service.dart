import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';
import 'package:flutter_dicoding_story/shared_value.dart';
import 'package:http/http.dart' as http;

class StoryService {
  Future<List<StoryModel>> getAllStory(int page, int size) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
          Uri.parse(
            '$baseUrl/stories?page=$page&size=$size',
          ),
          headers: {
            'Authorization': token,
          });

      if (kDebugMode) {
        print('$baseUrl/stories?page=$page&size=$size');
        print(token);
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
      }

      if (res.statusCode == 200) {
        return List<StoryModel>.from(
          jsonDecode(res.body)['listStory'].map(
            (story) => StoryModel.fromJson(story),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addStory() async {
    try {
      final token = await AuthService().getToken();

      // Map<String, String> headers = <String, String>{'Authorization': token};

      // Map<String, String> requestBody = <String, String>{'field1': value1};

      // var req = http.MultipartRequest('POST', Uri.parse('$baseUrl/stories'))
      //   ..headers.addAll(requestBody)
      //   ..fields.addAll(requestBody);

      // var res = await req.send();

      // if (kDebugMode) {
      //   print('$baseUrl/stories');
      //   print(token);
      //   print('Response status: ${res.statusCode}');
      //   print('Response body: ${res.stream.bytesToString()}');
      // }

      // final uri = Uri.parse('https://myendpoint.com');
      // var request = new http.MultipartRequest('POST', uri);
      // final httpImage = http.MultipartFile.fromBytes('files.myimage', bytes,
      //     contentType: MediaType.parse(mimeType), filename: 'myImage.png');
      // request.files.add(httpImage);
      // final response = await request.send();
    } catch (e) {
      rethrow;
    }
  }
}

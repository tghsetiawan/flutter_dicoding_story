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
}

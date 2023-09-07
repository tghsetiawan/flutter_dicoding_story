import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dicoding_story/model/response_getstory_model.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';
import 'package:flutter_dicoding_story/shared_value.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class StoryService {
  Future<List<ListStory>> getAllStory(int page, int size) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/stories?page=$page&size=$size',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (kDebugMode) {
        print('$baseUrl/stories?page=$page&size=$size');
        print(token);
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
      }

      if (res.statusCode == 200) {
        return List<ListStory>.from(
          jsonDecode(res.body)['listStory'].map(
            (story) => ListStory.fromJson(story),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StoryModel>> getAllStoryWithLocation(int page, int size) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/stories?page=$page&size=$size&location=1',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (kDebugMode) {
        print('$baseUrl/stories?page=$page&size=$size&location=1');
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

  Future<ResponseGetStory> getAllStoryWithLocation1(int page, int size) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/stories?page=$page&size=$size&location=1',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (kDebugMode) {
        print('$baseUrl/stories?page=$page&size=$size&location=1');
        print(token);
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
      }

      if (res.statusCode == 200) {
        // return List<StoryModel>.from(
        //   jsonDecode(res.body)['listStory'].map(
        //     (story) => StoryModel.fromJson(story),
        //   ),
        // ).toList();
        // ResponseGetStory responseGetStory =
        //     ResponseGetStory.fromJson(jsonDecode(response.body));
        final responseGetStory = responseGetStoryFromJson(res.body);
        return responseGetStory;
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  final dio = Dio();
  Future<void> addStoryDio(
      XFile pathImage, String descripiton, double lat, double lon) async {
    try {
      final token = await AuthService().getToken();

      var formData = FormData.fromMap({
        "description": descripiton,
        "photo": await MultipartFile.fromFile(pathImage.path),
        "lat": lat,
        "lon": lon,
      });

      final responsee = await dio.post(
        '$baseUrl/stories',
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print('$baseUrl/stories');
      print('Response headers: ${responsee.headers}');
      print('Response status: ${responsee.statusCode}');
      print('Response body: ${responsee.data}');
    } catch (e) {
      rethrow;
    }
  }
}

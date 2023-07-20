import 'dart:convert';

import 'package:flutter_dicoding_story/model/auth_model.dart';
import 'package:flutter_dicoding_story/model/login_model.dart';
import 'package:flutter_dicoding_story/model/login_result_model.dart';
import 'package:flutter_dicoding_story/model/register_model.dart';
import 'package:flutter_dicoding_story/model/response_login_model.dart';
import 'package:flutter_dicoding_story/model/response_model.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/shared_value.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> register(RegisterModel data) async {
    try {
      print('$baseUrl/register');
      print(data.toJson().toString());

      final response = await http.post(
        Uri.parse(
          '$baseUrl/register',
        ),
        body: data.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<ResponseLoginModel> login(LoginModel loginModel) async {
    try {
      print('$baseUrl/login');
      print(loginModel.toJson().toString());

      final response = await http.post(
        Uri.parse(
          '$baseUrl/login',
        ),
        body: loginModel.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ResponseLoginModel responseLoginModel =
            ResponseLoginModel.fromJson(jsonDecode(response.body));

        await storeCredentialLoginToLocal(responseLoginModel,
            loginModel.email.toString(), loginModel.password.toString());

        return responseLoginModel;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await clearLocalStorage();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> storeCredentialLoginToLocal(
      ResponseLoginModel responseLoginModel,
      String email,
      String password) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
      await storage.write(
          key: 'userId', value: responseLoginModel.loginResult!.userId);
      await storage.write(
          key: 'name', value: responseLoginModel.loginResult!.name);
      await storage.write(
          key: 'token', value: responseLoginModel.loginResult!.token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialRegisterToLocal(
      String email, String password) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final LoginModel data = LoginModel(
          email: values['email'],
          password: values['password'],
        );
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = "";

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<List<StoryModel>> getStory(int page, int size) async {
    try {
      print('$baseUrl/stories');

      final token = await AuthService().getToken();

      print(token);

      final res = await http.get(
          Uri.parse(
            '$baseUrl/stories?'
            'page=$page'
            '&size=$size',
          ),
          headers: {
            'Authorization': token,
          });

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

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

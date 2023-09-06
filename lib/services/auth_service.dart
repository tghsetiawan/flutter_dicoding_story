import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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
// import 'package:dio/dio.dart';

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

  // final dio = Dio();

  // Future<bool> checkinHIS(Float32x4 lat, Float32x4 lon) async {
  //   try {
  //     // final bodyRequest = {"email": "HIS.NUTECH@GMAIL.COM", "password": "his"};

  //     final bodyRequestCheckin = {
  //       "nik": "945493",
  //       "datetime": null,
  //       "working_status": "WFO",
  //       "image": null,
  //       "location_name":
  //           "Jl. Buncit Raya No.100, Pejaten Barat, Kota Jakarta Selatan, 12510",
  //       "latitude": lat,
  //       "longitude": lon,
  //       "area_code": "A01",
  //       "device_code": "1001",
  //       "manual_presence": false,
  //       "note": "masak air"
  //     };

  //     final responsee = await dio.post(
  //       '$baseUrlHis/presence/check-in',
  //       data: jsonEncode(bodyRequestCheckin),
  //       options: Options(
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Authorization':
  //               'BearereyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiVTJGc2RHVmtYMThLVHQxT2JTV1hYVGN3S0kvalpLckpxalpROWRNK1Q5RT0iLCJyb2xlX2lkIjoiVTJGc2RHVmtYMThzRkRuQ21zMEJZNHkxYnR5Vk1LeDhmWVdVSllzVVFtTT0iLCJuaWNrbmFtZSI6IkFETUlOIiwiYXJlYV9pZCI6IkNhbm5vdCByZWFkIHByb3BlcnRpZXMgb2YgbnVsbCAocmVhZGluZyAndG9TdHJpbmcnKSIsImlhdCI6MTY5MDQ1MDY3MSwiZXhwIjoxNjkwNTM3MDcxLCJpc3MiOiJIYXJkd2FyZSBJbnRlcmZhY2UgU29sdXRpb24ifQ.0UINn9U4SsmLHVGBN2l9ppAmeqOYbH_B4y3DGUf4Y98'
  //         },
  //       ),
  //     );

  //     print('$baseUrlHis/presence/check-in');
  //     print('Response headers: ${responsee.headers}');
  //     print('Response status: ${responsee.statusCode}');
  //     print('Response body: ${responsee.data}');

  //     return false;
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }
}

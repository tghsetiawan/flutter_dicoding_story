import 'dart:convert';
import 'dart:io';

import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';
import 'package:http/http.dart' as http;

class StoryService {
  static Future<List<StoryModel>> getCharacterList(
    int offset,
    int limit, {
    String? searchTerm,
  }) async =>
      http
          .get(
            _ApiUrlBuilder.characterList(offset, limit, searchTerm: searchTerm),
          )
          .mapFromResponse<List<StoryModel>, List<dynamic>>(
            (jsonArray) => _parseItemListFromJsonArray(
              jsonArray,
              (jsonObject) => StoryModel.fromJson(jsonObject),
            ),
          );

  static List<T> _parseItemListFromJsonArray<T>(
    List<dynamic> jsonArray,
    T Function(dynamic object) mapper,
  ) =>
      jsonArray.map(mapper).toList();
}

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}

class _ApiUrlBuilder {
  // static const _baseUrl = 'https://story-api.dicoding.dev/v1/';
  // static const _charactersResource = 'stories/';

  static const _baseUrl = 'https://www.breakingbadapi.com/api/';
  static const _charactersResource = 'characters/';

  static Uri characterList(
    int offset,
    int limit, {
    String? searchTerm,
  }) =>
      Uri.parse(
        '$_baseUrl$_charactersResource?'
        'offset=$offset'
        '&limit=$limit'
        '${_buildSearchTermQuery(searchTerm)}',
      );

  static String _buildSearchTermQuery(String? searchTerm) =>
      searchTerm != null && searchTerm.isNotEmpty
          ? '&name=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
          : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import '../model/word_model.dart';

class WordSearchRepository {
  static const url = "https://api.dictionaryapi.dev/api/v2/entries/en/";
  static final client = Client();

  static Future<WordModel> getWordData(String query) async {
    try {
      final response = await client.get(Uri.parse(url + query));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Map<String, dynamic> list = data[0];
        print(list);
        return WordModel.fromJson(list);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      rethrow;
    }
  }
}

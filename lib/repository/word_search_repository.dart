import 'dart:convert';
import 'package:http/http.dart';
import '../common/api.dart';
import '../model/word_model.dart';

class WordSearchRepository {
  static final client = Client();

  static Future<WordModel> getWordData(String query) async {
    try {
      final response = await client.get(Uri.parse(baseUrl + query));
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

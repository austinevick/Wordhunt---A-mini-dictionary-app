import 'package:shared_preferences/shared_preferences.dart';

import '../model/word_model.dart';
import '../repository/word_search_repository.dart';

class WordSearchProvider {
  static String WORDSEARCH = 'wordsearch';

  static Future<WordModel> getWordData(String query) async {
    return await WordSearchRepository.getWordData(query);
  }

  static Future<bool> saveWordHistory(List<String> wordList) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setStringList(WORDSEARCH, wordList);
  }

  static Future<List<String>> getWordHistory() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList(WORDSEARCH) ?? [];
  }
}

import 'package:wordhunt/db/word_db.dart';
import 'package:wordhunt/model/word_history_model.dart';

class WordSearchProvider {
  static Future<List<WordHistoryModel>> getWordHistory() async {
    return await WordDBHelper.getWordHistory();
  }

  static Future<WordHistoryModel> saveWordHistory(
      WordHistoryModel model) async {
    return await WordDBHelper.saveWord(model);
  }

  static Future<int> deleteHistory(int id) async {
    return await WordDBHelper.deleteWord(id);
  }
}

class WordHistoryModel {
  int? id;
  final String? word;
  final DateTime? dateTime;
  WordHistoryModel({
    this.id,
    this.word,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'dateTime': dateTime?.toIso8601String(),
    };
  }

  factory WordHistoryModel.fromMap(Map<String, dynamic> map) {
    return WordHistoryModel(
      id: map['id']?.toInt(),
      word: map['word'],
      dateTime:
          map['dateTime'] != null ? DateTime.parse(map['dateTime']) : null,
    );
  }
}

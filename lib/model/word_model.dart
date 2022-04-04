class WordModel {
  String? word;
  List<Phonetics>? phonetics;
  List<Meanings>? meanings;

  WordModel({this.word, this.phonetics, this.meanings});

  WordModel.fromJson(Map<String, dynamic> json) {
    word = json['word'] ?? '';
    if (json['phonetics'] != null) {
      phonetics = <Phonetics>[];
      json['phonetics'].forEach((v) {
        phonetics!.add(Phonetics.fromJson(v));
      });
    }
    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meanings.fromJson(v));
      });
    }
  }
}

class Phonetics {
  String? audio;
  String? sourceUrl;
  String? text;

  Phonetics({this.audio, this.sourceUrl, this.text});

  Phonetics.fromJson(Map<String, dynamic> json) {
    audio = json['audio'] ?? '';
    sourceUrl = json['sourceUrl'];

    text = json['text'] ?? '';
  }
}

class Meanings {
  String? partOfSpeech;
  List<Definitions>? definitions;
  List<dynamic>? synonyms;
  List<dynamic>? antonyms;

  Meanings({this.partOfSpeech, this.definitions, this.synonyms, this.antonyms});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'] ?? '';
    if (json['definitions'] != null) {
      definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        definitions!.add(Definitions.fromJson(v));
      });
    }
    synonyms = json['synonyms'] as List<dynamic>;
    antonyms = json['antonyms'] as List<dynamic>;
  }
}

class Definitions {
  String? definition;
  List<dynamic>? synonyms;
  List<dynamic>? antonyms;
  String? example;

  Definitions({this.definition, this.synonyms, this.antonyms, this.example});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'] ?? '';
    synonyms = json['synonyms'] as List<dynamic>;
    antonyms = json['antonyms'] as List<dynamic>;
    example = json['example'] ?? '';
  }
}

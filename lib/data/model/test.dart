class Test {
  final String id;
  final String title;
  final String description;
  final String source;
  final String? imageUrl;
  final String? note;
  final List<Question> questions;
  final ConcludeDetail conclude;

  Test({
    required this.id,
    required this.title,
    required this.description,
    required this.source,
    this.imageUrl,
    this.note,
    required this.questions,
    required this.conclude
  });

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      source: map['source'],
      imageUrl: map['imageUrl'],
      note: map['note'],
      questions: (map['questions'] as List<dynamic>)
          .map((q) => Question.fromMap(q))
          .toList(),
      conclude: ConcludeDetail.fromMap(map['conclude']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'source': source,
      'imageUrl': imageUrl,
      'note': note,
      'questions': questions.map((q) => q.toMap()).toList(),
      'conclude': conclude.toMap(),
    };
  }

  void clearAllAnswers() {
    for (var question in questions) {
      question.selectedOptionIndex = null;
    }
  }
}

class ConcludeDetail {
  final Map<String, LevelDetail> levels;

  ConcludeDetail({required this.levels});

  factory ConcludeDetail.fromMap(Map<String, dynamic> map) {
    return ConcludeDetail(
      levels: Map<String, LevelDetail>.from(
          map.map((key, value) => MapEntry(key, LevelDetail.fromMap(value)))
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return levels.map((key, value) => MapEntry(key, value.toMap()));
  }
}

class LevelDetail {
  final String conclusion;
  final String? strengths;
  final String? weaknesses;
  final String scoringGuide;
  final String recommendations;
  final String description;

  LevelDetail({
    required this.conclusion,
    this.strengths,
    this.weaknesses,
    required this.recommendations,
    required this.scoringGuide,
    required this.description
  });

  factory LevelDetail.fromMap(Map<String, dynamic> map) {
    return LevelDetail(
      conclusion: map['conclusion'],
      strengths: map['strengths'],
      weaknesses: map['weaknesses'],
      recommendations: map['recommendations'],
      scoringGuide : map['scoringGuide'],
      description : map['description']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'conclusion': conclusion,
      'strengths': strengths,
      'weaknesses': weaknesses,
      'recommendations': recommendations,
      'scoringGuide' : scoringGuide,
      'description' : description
    };
  }
}

class Question {
  final String text;
  final List<String> options;
  int? selectedOptionIndex;

  Question({
    required this.text,
    required this.options,
    this.selectedOptionIndex,
  });

  void selectOption(int index) {
    selectedOptionIndex = index;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'],
      options: List<String>.from(map['options']),
      selectedOptionIndex: map['selectedOptionIndex'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'options': options,
      'selectedOptionIndex': selectedOptionIndex,
    };
  }
}
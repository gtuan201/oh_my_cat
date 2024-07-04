class Test {
  final String id;
  final String title;
  final String description;
  final String source;
  final String? imageUrl;

  Test({
    required this.id,
    required this.title,
    required this.description,
    required this.source,
    this.imageUrl,
  });

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      source: map['source'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'source': source,
      'imageUrl': imageUrl,
    };
  }
}

class Question {
  final int? id;
  final int testId;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String? imageUrl;
  int? selectedOptionIndex;

  Question({
    this.id,
    required this.testId,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    this.imageUrl,
    this.selectedOptionIndex,
  });

  bool isCorrect() {
    return selectedOptionIndex == correctOptionIndex;
  }

  void selectOption(int index) {
    selectedOptionIndex = index;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      testId: map['testId'],
      text: map['text'],
      options: (map['options'] as String).split('|'),
      correctOptionIndex: map['correctOptionIndex'],
      imageUrl: map['imageUrl'],
      selectedOptionIndex: map['selectedOptionIndex'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'testId': testId,
      'text': text,
      'options': options.join('|'),
      'correctOptionIndex': correctOptionIndex,
      'imageUrl': imageUrl,
      'selectedOptionIndex': selectedOptionIndex,
    };
  }
}
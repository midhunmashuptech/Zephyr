import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/test/model/ai_quiz_model.dart';
import 'package:zephyr/features/test/model/chapter_options_model.dart';
import 'package:zephyr/features/test/model/class_subject_options_model.dart';
import 'package:zephyr/features/test/model/topic_options_model.dart';
import 'package:zephyr/features/test/screens/test_loading.dart';
import 'package:zephyr/features/test/screens/test_quiz_screen.dart';
import 'package:zephyr/features/test/service/make_your_test_service.dart';

class MakeTestProvider extends ChangeNotifier {
  bool _isOptionsLoading = false;
  bool get isOptionsLoading => _isOptionsLoading;

  bool _isChapterOptionsLoading = false;
  bool get isChapterOptionsLoading => _isChapterOptionsLoading;

  bool _isTopicOptionsLoading = false;
  bool get isTopicOptionsLoading => _isTopicOptionsLoading;

  List<Classes> _classes = [];
  List<Classes> get classes => _classes;

  List<Subjects> _subjects = [];
  List<Subjects> get subjects => _subjects;

  List<Chapters> _chapters = [];
  List<Chapters> get chapters => _chapters;

  List<Topics> _topics = [];
  List<Topics> get topics => _topics;

  List<String> _classOptions = [];
  List<String> get classOptions => _classOptions;
  List<String> _subjectOptions = [];
  List<String> get subjectOptions => _subjectOptions;

  int? selectedClass;
  int? selectedSubject;
  int? selectedChapter;
  int? selectedTopic;
  int? selectedQuesCount = 10;
  String? selectedDifficultyLevel = "medium";

  // Quiz Data
  List<Questions> _aiGeneratedQuiz = [];
  List<Questions> get aiGeneratedQuiz => _aiGeneratedQuiz;
  int currentQuestion = 0;
  int? correctOption;

  void nextQuestion() {
    if (currentQuestion < (aiGeneratedQuiz.length - 1)) {
      currentQuestion++;
      correctOption = aiGeneratedQuiz[currentQuestion].correctOption;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestion > 0) {
      currentQuestion--;
      correctOption = aiGeneratedQuiz[currentQuestion].correctOption;
      notifyListeners();
    }
  }

  void printAllSelectedValues() {
    print(selectedClass);
    print(selectedSubject);
    print(selectedChapter);
    print(selectedTopic);
    print(selectedQuesCount);
    print(selectedDifficultyLevel);
  }

  void clearAllSelectedValues() {
    selectedClass = null;
    selectedSubject = null;
    selectedChapter = null;
    selectedTopic = null;
    selectedQuesCount = 10;
    selectedDifficultyLevel = "medium";
    notifyListeners();
  }

  void setQuestionCount(int? option) async {
    selectedQuesCount = option;
    notifyListeners();
  }

  void setDifficltyevel(String? option) async {
    selectedDifficultyLevel = (option ?? "").toLowerCase();
    notifyListeners();
  }

  void setSelectedClass(int? option) async {
    selectedClass = option;
    notifyListeners();

    if (selectedClass != null && selectedSubject != null) {
      await fetchChapterOptions();
      notifyListeners();
    }
  }

  void setSelectedSubject(int? option) async {
    selectedSubject = option;
    notifyListeners();

    if (selectedClass != null && selectedSubject != null) {
      await fetchChapterOptions();
      notifyListeners();
    }
  }

  void setSelectedChapter(int? option) async {
    selectedChapter = option;
    notifyListeners();

    if (selectedClass != null &&
        selectedSubject != null &&
        selectedChapter != null) {
      await fetchTopicOptions();
      notifyListeners();
    }
  }

  void setSelectedTopic(int? option) {
    selectedTopic = option;
    notifyListeners();
  }
  
  //Subject Options
  Future<void> fetchClassSubjectsOptions() async {
    _isOptionsLoading = true;
    notifyListeners();

    final response = await MakeYourTestService().getClassSubjectOptionsModel();
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _classes = response.classes ?? [];
        _subjects = response.subjects ?? [];

        _classOptions = classes.map((clas) => clas.title ?? "").toList();
        _subjectOptions =
            subjects.map((subject) => subject.title ?? "").toList();
      } else {
        _classOptions = [];
        _subjectOptions = [];
      }
    }
    notifyListeners();

    _isOptionsLoading = false;
    notifyListeners();
  }
 
 //Chapter Options
  Future<void> fetchChapterOptions() async {
    _isChapterOptionsLoading = true;
    notifyListeners();

    final response = await MakeYourTestService().getChapterOptionsModel(
        (selectedSubject ?? 1).toString(), (selectedClass ?? "11").toString());
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _chapters = response.chapters ?? [];
      } else {
        _chapters = [];
      }
    }
    notifyListeners();

    _isChapterOptionsLoading = false;
    notifyListeners();
  }
 //Topic Options
  Future<void> fetchTopicOptions() async {
    _isTopicOptionsLoading = true;
    notifyListeners();

    final response = await MakeYourTestService()
        .getTopicOptionsModel((selectedChapter ?? 1).toString());
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _topics = response.topics ?? [];
      } else {
        _topics = [];
      }
    }
    notifyListeners();

    _isTopicOptionsLoading = false;
    notifyListeners();
  }

  // Prepare Quiz API
  Future<void> prepareGeneratedQuiz(BuildContext context) async {
    if (selectedSubject == null ||
        selectedChapter == null ||
        selectedTopic == null ||
        selectedDifficultyLevel == null ||
        selectedQuesCount == null) {
      showSnackBar("Warning", "Fill all the Options");
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TestLoading()));
    }
  }

  Future<void> generateQuiz(BuildContext context) async {
    currentQuestion = 0;
    _aiGeneratedQuiz = [];
    notifyListeners();

    final response = await MakeYourTestService().generateAiQuiz(
        (subjects)
                .firstWhere((subject) => subject.id == selectedSubject)
                .title ??
            "physics",
        (chapters)
                .firstWhere((chapter) => chapter.id == selectedChapter)
                .title ??
            "2 simensional",
        (topics).firstWhere((topic) => topic.id == selectedTopic).title ??
            "vectors",
        selectedDifficultyLevel ?? "medium",
        (selectedQuesCount ?? 10).toString());

    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        print("success ${(response.questions ?? []).length}");
        _aiGeneratedQuiz = response.questions ?? [];
        currentQuestion = 0;
        correctOption = aiGeneratedQuiz[0].correctOption;

        notifyListeners();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TestQuizScreen()));
      } else {
        showSnackBar("Error", "Something went wrong! Try Again");
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }
}

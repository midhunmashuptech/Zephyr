import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/test/model/ai_quiz_model.dart';
import 'package:zephyr/features/test/model/chapter_options_model.dart';
import 'package:zephyr/features/test/model/class_subject_options_model.dart';
import 'package:zephyr/features/test/model/topic_options_model.dart';

class MakeYourTestService {

  //Subject Options
  Future<ClassSubjectOptionsModel?> getClassSubjectOptionsModel() async {
    final responseJson = await ApiService()
        .postRequest(url: getClassSubjectOptionsUrl, fields: {});

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final classSubjectOptionsModel =
          ClassSubjectOptionsModel.fromJson(responseJson);
      if (classSubjectOptionsModel.type == "success") {
        return classSubjectOptionsModel;
      } else {
        return classSubjectOptionsModel;
      }
    }
  }
  //Chapter Options
  Future<ChapterOptionsModel?> getChapterOptionsModel(
      String subjectId, String classId) async {
    print("subject_id $subjectId, class_id $classId");
    final responseJson = await ApiService().postRequest(
        url: getChapterOptionsUrl,
        fields: {"subject_id": subjectId, "class_id": classId});

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final chaptersOptionsModel = ChapterOptionsModel.fromJson(responseJson);
      if (chaptersOptionsModel.type == "success") {
        return chaptersOptionsModel;
      } else {
        return chaptersOptionsModel;
      }
    }
  }
 //Topic Options
  Future<TopicOptionsModel?> getTopicOptionsModel(String chapterId) async {
    final responseJson = await ApiService().postRequest(
        url: getTopicOptionsUrl, fields: {"chapter_id": chapterId});

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final topicOptionsModel = TopicOptionsModel.fromJson(responseJson);
      if (topicOptionsModel.type == "success") {
        return topicOptionsModel;
      } else {
        return topicOptionsModel;
      }
    }
  }
  //AI Quiz
  Future<AiQuizModel?> generateAiQuiz(String subject, String chapter,
      String topic, String difficulty, String count) async {
        print("started generating");
    final responseJson =
        await ApiService().postRequest(url: generateAiQuizUrl, fields: {
      "type": "mcq",
      "subject": subject,
      "chapter": chapter,
      "topic": topic,
      "difficulty": difficulty,
      "count": count
    });
    
        print("finished generating");

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final aiQuizModel = AiQuizModel.fromJson(responseJson);
      if (aiQuizModel.type == "success") {
        print("succesfully generated");
        return aiQuizModel;
      } else {
        return aiQuizModel;
      }
    }
  }
}

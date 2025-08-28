import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/test/model/chapter_options_model.dart';
import 'package:zephyr/features/test/model/class_subject_options_model.dart';
import 'package:zephyr/features/test/model/topic_options_model.dart';

class MakeYourTestService {
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

  Future<TopicOptionsModel?> generateAiQuiz(String chapterId) async {
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
}

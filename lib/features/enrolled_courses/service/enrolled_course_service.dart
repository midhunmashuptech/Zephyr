import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_chapter_model.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_model.dart';

class EnrolledCourseService {
  final ApiService _apiService = ApiService();

  //Enrolled Chapter
  Future<EnrolledChapterModel?> getEnrolledChapter(
    BuildContext context, {
    required String enrollmentId,
    required String courseSubjectId,
  }) async {
    final responseJson = await _apiService.postRequest(
      url: enrolledChapterUrl,
      fields: {
        "enrollment_id": enrollmentId,
        "course_subject_id": courseSubjectId
      },
    );

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final enrolledChapterModel = EnrolledChapterModel.fromJson(responseJson);
      if (enrolledChapterModel.type == "success") {
        return enrolledChapterModel;
      }
      return null;
    }
  }

  //Enrolled Course
  Future<EnrolledCourseModel?> getEnrolledCourse({
   required BuildContext context,
  }) async {
    final responseJson = await _apiService.getRequest(url: enrolledCourseUrl);

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final enrolledCourseModel = EnrolledCourseModel.fromJson(responseJson);
      if (enrolledCourseModel.type == "success") {
        return enrolledCourseModel;
      }
      return null;
    }
  }
}

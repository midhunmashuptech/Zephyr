import 'package:flutter/material.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_materials_model.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_video_model.dart';

class EnrolledChapterDetailsService {
  //Enrolled Chapter
  Future<EnrolledChapterVideosModel?> getEnrolledChapterVideos(
    BuildContext context, {
    required String enrollmentId,
    required String courseSubjectId,
    required String courseChapterId,
  }) async {
    final responseJson = await ApiService().postRequest(
      url: enrolledChapterVideosUrl,
      fields: {
        "enrollment_id": enrollmentId,
        "course_subject_id": courseSubjectId,
        "course_chapter_id": courseChapterId
      },
    );

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final enrolledChapterVideosModel =
          EnrolledChapterVideosModel.fromJson(responseJson);
      if (enrolledChapterVideosModel.type == "success") {
        return enrolledChapterVideosModel;
      }
      return null;
    }
  }

  //Enrolled Chapter Materials
  Future<EnrolledChapterMaterialsModel?> getEnrolledChapterMaterials({
    required String enrollmentId,
    required String courseSubjectId,
    required String courseChapterId,
  }) async {
    final responseJson = await ApiService()
        .postRequest(url: enrolledChapterMaterialsUrl, fields: {
      "enrollment_id": enrollmentId,
      "course_subject_id": courseSubjectId,
      "course_chapter_id": courseChapterId
    });
    if (responseJson == null) {
      showSnackBar("Error", "Failed loading enrolled chapter materials");
    } else {
      final enrolledChapterMaterials =
          EnrolledChapterMaterialsModel.fromJson(responseJson);
      showSnackBar("success", "Successfully loaded enrolled chapter materials");
      return enrolledChapterMaterials;
    }
    return null;
  }
}

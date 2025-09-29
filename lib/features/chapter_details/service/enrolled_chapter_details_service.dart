import 'package:flutter/material.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_analysis_model.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_materials_model.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_test_model.dart';
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
      return null;
    } else {
      final enrolledChapterMaterials =
          EnrolledChapterMaterialsModel.fromJson(responseJson);
      return enrolledChapterMaterials;
    }
  }

  //Enrolled Chapter Tests
  Future<EnrolledChapterTestModel?> getEnrolledChapterTest(
      {required BuildContext context,
      required String enrollmentId,
      required String courseSubjectId,
      required String courseChapterId}) async {
    final responseJson =
        await ApiService().postRequest(url: enrolledChapterTestUrl, fields: {
      "enrollment_id": enrollmentId,
      "course_subject_id": courseSubjectId,
      "course_chapter_id": courseChapterId
    });
    if (responseJson == null) {
      return null;
    } else {
      final enrolledChapterTestModel =
          EnrolledChapterTestModel.fromJson(responseJson);
      return enrolledChapterTestModel;
    }
  }

  //Enrolled Chapter Tests
  Future<EnrolledChapterAnalysisModel?> getEnrolledChapterAnalysis(
      {required BuildContext context,
      required String enrollmentId,
      required String courseSubjectId,
      required String courseChapterId}) async {
    final responseJson = await ApiService()
        .postRequest(url: enrolledChapterAnalysisUrl, fields: {
      "enrollment_id": enrollmentId,
      "course_subject_id": courseSubjectId,
      "course_chapter_id": courseChapterId
    });

    if (responseJson == null) {
      return null;
    } else {
      final enrolledChapterAnalysisModel =
          EnrolledChapterAnalysisModel.fromJson(responseJson);
      return enrolledChapterAnalysisModel;
    }
  }
}

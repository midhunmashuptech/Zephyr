import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/enrolled_courses/model/course_enrollments_model.dart';
import 'package:zephyr/features/enrolled_courses/model/course_detail_model.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_chapter_model.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_model.dart';
import 'package:zephyr/features/enrolled_courses/model/post_course_review_model.dart';

class EnrolledCourseService {
  final ApiService _apiService = ApiService();

  
  // Course Enrollments
  Future<CourseEnrollmentsModel?> getCourseEnrollments(BuildContext context,
      {required String courseId}) async {
    final responseJson =
        await _apiService.getRequest(url: courseEnrollmentsUrl + courseId);

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final courseEnrollmentsModel =
          CourseEnrollmentsModel.fromJson(responseJson);
      if (courseEnrollmentsModel.type == "success") {
        return courseEnrollmentsModel;
      } else {
        return courseEnrollmentsModel;
      }
    }
  }

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
      if (enrolledCourseModel.type == "success" || enrolledCourseModel.type == "error") {
        return enrolledCourseModel;
      }
      return null;
    }
  }

  // Get course details
  Future<CourseDetailModel?> getCourseDetails({
    required String courseId,
    required BuildContext context,
  }) async {
    final responseJson = await _apiService
        .postRequest(url: courseDetailUrl, fields: {"course_id": courseId});

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final courseDetailModel = CourseDetailModel.fromJson(responseJson);
      if (courseDetailModel.type == "success") {
        return courseDetailModel;
      }
      return null;
    }
  }

  // Get course reviews in course details page

  // Post course review
  Future<PostCourseReviewModel?> postCourseReview(
      {required BuildContext context,
      required String courseId,
      required String rating,
      required String review}) async {
    final responseJson = await ApiService().postRequest(
        url: postCourseReviewUrl,
        fields: {"course_id": courseId, "rating": rating, "review": review});
    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("error", "something went wrong");
      return null;
    } else {
      final postCourseReviewModel = PostCourseReviewModel.fromJson(responseJson);
      if (postCourseReviewModel.type == "success") {
        return postCourseReviewModel;
      }
    }
  }
}

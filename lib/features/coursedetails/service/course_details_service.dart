import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/coursedetails/model/course_detail_model.dart';
import 'package:zephyr/features/coursedetails/model/get_course_reviews_model.dart';
import 'package:zephyr/features/enrolled_courses/model/post_course_review_model.dart';

class CourseDetailsService {
  Future<CourseDetailModel?> fetchCourseDetails(
      {required BuildContext context, required String courseId}) async {
    final responseJson = await ApiService()
        .postRequest(url: courseDetailUrl, fields: {"course_id": courseId});
    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("error", "something went wrong");
      return null;
    } else {
      final courseDetailModel = CourseDetailModel.fromJson(responseJson);
      if (courseDetailModel.type == "success") {
        return courseDetailModel;
      }
      return null;
    }
  }

  Future<GetCourseReviewsModel?> fetchCourseReviews(
      {required BuildContext context, required String courseId}) async {
    final responseJson =
        await ApiService().getRequest(url: "$getCourseReviewsUrl$courseId");
    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("error", "something went wrong");
      return null;
    } else {
      final fetchedCourseReviewsModel =
          GetCourseReviewsModel.fromJson(responseJson);
      if (fetchedCourseReviewsModel.type == "success") {
        return fetchedCourseReviewsModel;
      }
    }
  }
}

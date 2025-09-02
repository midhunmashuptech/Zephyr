import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/coursedetails/model/course_detail_model.dart';

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
    }
  }
}

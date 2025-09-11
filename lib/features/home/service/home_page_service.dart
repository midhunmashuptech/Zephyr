import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/home/model/active_course_model.dart';
import 'package:zephyr/features/home/model/featured_course_model.dart';

class HomePageService {
  //Active Courses
  Future<ActiveCourseModel?> getActiveCourses(BuildContext context) async {
    final responseJson =
        await ApiService().getRequest(url: getActiveCoursesUrl);

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final activeCourseModel = ActiveCourseModel.fromJson(responseJson);
      if (activeCourseModel.type == "success" ||
          activeCourseModel.type == "error") {
        return activeCourseModel;
      }
      return null;
    }
  }

  //Featured Courses
  Future<FeaturedCourseModel?> getfeaturedCourse(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: getFeaturedCourseUrl);
      final featuredCourseModel =
           FeaturedCourseModel.fromJson(responseJson);
      if (featuredCourseModel.type == "success") {
        return featuredCourseModel;
      }
      return null;
    }
}

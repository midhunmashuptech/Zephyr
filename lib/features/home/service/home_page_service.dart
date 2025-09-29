import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/home/model/active_course_model.dart';
import 'package:zephyr/features/home/model/banner_images_model.dart';
import 'package:zephyr/features/home/model/category_based_course_model.dart';
import 'package:zephyr/features/home/model/featured_course_model.dart';

class HomePageService {
  //Active Courses
  Future<ActiveCourseModel?> getActiveCourses(BuildContext context) async {
    final responseJson =
        await ApiService().getRequest(url: getActiveCoursesUrl);

    if (responseJson == null || responseJson.isEmpty) {
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
    if (responseJson == null) {
    } else {
      final featuredCourseModel = FeaturedCourseModel.fromJson(responseJson);
      if (featuredCourseModel.type == "success") {
        return featuredCourseModel;
      }
    }
      return null;
  }

  // Category Based Courses
  Future<CategoryBasedCourseModel?> getCategoryBasedCourse(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: getCategoryBasedCourseUrl);
    if (responseJson == null) {
    } else {
      final categoryBasedCourseModel = CategoryBasedCourseModel.fromJson(responseJson);
      if (categoryBasedCourseModel.type == "success") {
        return categoryBasedCourseModel;
      }
    }
      return null;
  }

  //Featured Courses
  Future<BannerImagesModel?> getBannerImages(
      {required BuildContext context}) async {

    final responseJson =
        await ApiService().getRequest(url: getBannerImagesUrl);
    if (responseJson == null) {
    } else {
      final bannerImagesModel = BannerImagesModel.fromJson(responseJson);
      if (bannerImagesModel.type == "success") {
        return bannerImagesModel;
      }
    }
      return null;
  }
}

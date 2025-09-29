import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/home/model/active_course_model.dart';
import 'package:zephyr/features/home/model/banner_images_model.dart';
import 'package:zephyr/features/home/model/category_based_course_model.dart'
    as category_based_courses_model;
import 'package:zephyr/features/home/model/featured_course_model.dart'
    as featured_model;
import 'package:zephyr/features/home/service/home_page_service.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isActiveCoursesLoading = false;
  bool get isActiveCoursesLoading => _isActiveCoursesLoading;

  bool _isFeaturedCourseLoading = false;
  bool get isFeaturedCourseLoading => _isFeaturedCourseLoading;

  bool _isCategoryCourseLoading = false;
  bool get isCategoryCourseLoading => _isCategoryCourseLoading;

  List<category_based_courses_model.AllCourses> _categoryBasedCourses = [];
  List<category_based_courses_model.AllCourses> get categoryBasedCourses =>
      _categoryBasedCourses;

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;

  category_based_courses_model.AllCourses _selectedCategoryCourses =
      category_based_courses_model.AllCourses();
  category_based_courses_model.AllCourses get selectedCategoryCourses =>
      _selectedCategoryCourses;

  bool _isBannerImagesLoading = false;
  bool get isBannerImagesLoading => _isBannerImagesLoading;

  List<Banners> _bannerImages = [];
  List<Banners> get bannerImages => _bannerImages;

  void changeCategory(int categoryId) {
    _selectedCategory = _categoryBasedCourses
            .firstWhere((category) => category.id == categoryId)
            .id ??
        0;
    _selectedCategoryCourses = _categoryBasedCourses
        .firstWhere((category) => category.id == categoryId);
    notifyListeners();
  }

  List<Course> _activeCourses = [];
  List<Course> get activeCourses => _activeCourses;

  List<Course> _filteredActiveCourses = [];
  List<Course> get filteredActiveCourses => _filteredActiveCourses;

  List<featured_model.Courses> _featuredCourses = [];
  List<featured_model.Courses> get featuredCourses => _featuredCourses;

  void filterActiveCourses(String? searchValue) {
    _filteredActiveCourses = activeCourses
        .where((course) => (course.title ?? "")
            .toLowerCase()
            .contains((searchValue ?? "").toLowerCase()))
        .toList();
    notifyListeners();
  }

  // Banner Images
  Future<void> fetchBannerImages(BuildContext context) async {
    _isBannerImagesLoading = true;
    notifyListeners();

    final response = await HomePageService().getBannerImages(context: context);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
      _bannerImages = [];
      _isBannerImagesLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _bannerImages = response.banners ?? [];
        notifyListeners();

        _isBannerImagesLoading = false;
        notifyListeners();
      } else {
        showSnackBar("Error", "Something went wrong! please try again");
        _bannerImages = [];
        notifyListeners();

        _isBannerImagesLoading = false;
        notifyListeners();
      }
    }
  }

  //Active Courses
  Future<void> fetchActiveCouses(BuildContext context) async {
    _isActiveCoursesLoading = true;
    _activeCourses = [];
    _isFeaturedCourseLoading = true;
    _isCategoryCourseLoading = true;
    _isBannerImagesLoading = true;
    _featuredCourses = [];
    notifyListeners();

    final response = await HomePageService().getActiveCourses(context);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
      _activeCourses = [];
      _filteredActiveCourses = [];
      _isActiveCoursesLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _activeCourses = response.course ?? [];
        _filteredActiveCourses = response.course ?? [];
        notifyListeners();

        _isActiveCoursesLoading = false;
        notifyListeners();
      } else {
        _activeCourses = [];
        _filteredActiveCourses = [];
        notifyListeners();

        _isActiveCoursesLoading = false;
        notifyListeners();
      }
    }
  }

  //Featured Courses
  Future<void> fetchFeaturedCourses({required BuildContext context}) async {
    _isFeaturedCourseLoading = true;
    notifyListeners();
    final response =
        await HomePageService().getfeaturedCourse(context: context);
    if (response == null) {
      showSnackBar("Error", "Error Loading Featured Courses");
      _isFeaturedCourseLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _featuredCourses = response.courses ?? [];
        _isFeaturedCourseLoading = false;
        notifyListeners();

        debugPrint("Featured Courses: ${featuredCourses.length}");
      }
    }
  }

  //Category Based Courses
  Future<void> fetchCategoryBasedCourses(
      {required BuildContext context}) async {
    _categoryBasedCourses = [];
    _isCategoryCourseLoading = true;
    notifyListeners();

    final response =
        await HomePageService().getCategoryBasedCourse(context: context);

    if (response == null) {
      showSnackBar("Error", "Error Fetching Featured Courses");
      _isCategoryCourseLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _categoryBasedCourses = response.allCourses ?? [];
        _categoryBasedCourses
            .sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
        _selectedCategory = _categoryBasedCourses[0].id ?? 0;
        _selectedCategoryCourses = _categoryBasedCourses[0];
        notifyListeners();
        _isCategoryCourseLoading = false;
        notifyListeners();
      }
    }
  }
}

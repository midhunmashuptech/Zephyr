import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/enrolled_courses/model/course_detail_model.dart'
    as courseDetailsModel;
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_model.dart';
import 'package:zephyr/features/enrolled_courses/service/enrolled_course_service.dart';

class EnrolledCourseProvider extends ChangeNotifier {
  bool _isChapterLoading = false;
  bool get isChapterLoading => _isChapterLoading;

  List<String> _chapterList = [];
  List<String> get chapterList => _chapterList;

  bool _isCourseLoading = false;
  bool get isCourseLoading => _isCourseLoading;

  List<Subscriptions> _enrolledCourses = [];
  List<Subscriptions> get enrolledCourses => _enrolledCourses;

  List<Subscriptions> _filteredCourses = [];
  List<Subscriptions> get filteredCourses => _filteredCourses;

  void filterCourses(String? searchValue) {
    _filteredCourses = enrolledCourses
        .where((course) => (course.courseTitle ?? "")
            .toLowerCase()
            .contains((searchValue ?? "").toLowerCase()))
        .toList();
    notifyListeners();
  }

  bool _isCourseDetailsLoading = false;
  bool get isCourseDetailsLoading => _isCourseDetailsLoading;

  courseDetailsModel.Data _selectedCourseDetails = courseDetailsModel.Data();
  courseDetailsModel.Data get selectedCourseDetails => _selectedCourseDetails;

  List<courseDetailsModel.Chapters> getChapters(int index) {
    return (selectedCourseDetails.subjects ?? [])[index].chapters ?? [];
  }

  //Enrolled Chapters
  Future<void> fetchEnrolledChapter(
    BuildContext context,
    String enrollmentId,
    String courseSubjectId,
  ) async {
    _isChapterLoading = true;
    notifyListeners();

    final response = await EnrolledCourseService().getEnrolledChapter(context,
        enrollmentId: enrollmentId, courseSubjectId: courseSubjectId);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      print(response.type ?? "None");
      if (response.type == "success") {
        _chapterList = (response.chapters ?? [])
            .map((chapter) => chapter.chapterTitle ?? "")
            .toList();
      } else {
        _chapterList = [];
      }
    }
    notifyListeners();
    _isChapterLoading = false;
    notifyListeners();
  }

  //Enrolled Course
  Future<void> fetchEnrolledCourse(
    BuildContext context,
  ) async {
    _isCourseLoading = true;
    notifyListeners();

    final response =
        await EnrolledCourseService().getEnrolledCourse(context: context);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _enrolledCourses = response.subscriptions ?? [];
        _filteredCourses = _enrolledCourses;
      } else {
        _enrolledCourses = [];
        _filteredCourses = _enrolledCourses;
      }
    }
    notifyListeners();
    _isCourseLoading = false;
    notifyListeners();
  }

  // Get Course Details
  Future<void> getCourseDetails(BuildContext context, String courseId) async {
    _isCourseDetailsLoading = true;
    notifyListeners();

    final response = await EnrolledCourseService()
        .getCourseDetails(context: context, courseId: courseId);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _selectedCourseDetails = response.data ?? courseDetailsModel.Data();
      } else {
        _selectedCourseDetails = courseDetailsModel.Data();
      }
    }
    notifyListeners();

    _isCourseDetailsLoading = false;
    notifyListeners();
  }
}

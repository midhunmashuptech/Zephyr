import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/coursedetails/model/course_detail_model.dart';
import 'package:zephyr/features/coursedetails/model/get_course_reviews_model.dart';
import 'package:zephyr/features/coursedetails/service/course_details_service.dart';

class CourseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isReviewsLoading = false;
  bool get isReviewsLoading => _isReviewsLoading;

  Data _courseData = Data();
  Data get courseData => _courseData;

  List<Reviews> _courseReviews = [];
  List<Reviews> get courseReviews => _courseReviews;

  Chapters _selectedChapter = Chapters();
  Chapters get selectedChapter => _selectedChapter;

  void setSelectedChapterContents(Chapters chapter) {
    _selectedChapter = chapter;
    notifyListeners();
  }

  Future<void> getCourseDetails(
      {required String courseId, required BuildContext context}) async {
    _isLoading = true;
    _courseData = Data();
    notifyListeners();
    final response = await CourseDetailsService()
        .fetchCourseDetails(context: context, courseId: courseId);
    if (response == null) {
      showSnackBar("error", "something went wrong");
      _isLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _courseData = response.data ?? Data();
        notifyListeners();
        _isLoading = false;
        notifyListeners();
      } else {
        showSnackBar("error", "something went wrong");
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> getCourseReviews(
      {required String courseId, required BuildContext context}) async {
    _isReviewsLoading = true;
    _courseReviews = [];
    notifyListeners();

    final response = await CourseDetailsService()
        .fetchCourseReviews(context: context, courseId: courseId);

    if (response == null) {
      showSnackBar("error", "something went wrong");
      _isReviewsLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _courseReviews = response.reviews ?? [];
        notifyListeners();
        _isReviewsLoading = false;
        notifyListeners();
      } else {
        showSnackBar("error", "something went wrong");
        _isReviewsLoading = false;
        notifyListeners();
      }
    }
  }
}

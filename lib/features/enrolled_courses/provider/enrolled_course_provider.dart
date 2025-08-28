import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/enrolled_courses/service/enrolled_course_service.dart';

class EnrolledCourseProvider extends ChangeNotifier {
  bool _isChapterLoading = false;
  bool get isChapterLoading => _isChapterLoading;

  List<String> _chapterList = [];
  List<String> get chapterList => _chapterList;

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
}

import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/home/model/active_course_model.dart';
import 'package:zephyr/features/home/service/home_page_service.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isActiveCoursesLoading = false;
  bool get isActiveCoursesLoading => _isActiveCoursesLoading;

  List<Course> _activeCourses = [];
  List<Course> get activeCourses => _activeCourses;

  List<Course> _filteredActiveCourses = [];
  List<Course> get filteredActiveCourses => _filteredActiveCourses;

  void filterActiveCourses(String? searchValue) {
    _filteredActiveCourses = activeCourses
        .where((course) => (course.title ?? "")
            .toLowerCase()
            .contains((searchValue ?? "").toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> fetchActiveCouses(BuildContext context) async {
    _isActiveCoursesLoading = true;
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
}

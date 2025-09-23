import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/coursedetails/model/course_detail_model.dart';
import 'package:zephyr/features/coursedetails/service/course_details_service.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Data _courseData = Data();
  Data get courseData => _courseData;

  double _totalPayable = 0.0;
  double get totalPayable => _totalPayable;
  

  void applyCouponDiscount(){}
  void removeCouponDiscount(){}

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
        if (_courseData.type == "amount") {
          _totalPayable =
              ((_courseData.price ?? 0) - (_courseData.discountValue ?? 0))
                  .toDouble();
        } else {
          _totalPayable = (_courseData.price ?? 0).toDouble();
        }
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
}

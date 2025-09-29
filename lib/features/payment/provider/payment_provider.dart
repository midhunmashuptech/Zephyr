import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/features/coursedetails/model/course_detail_model.dart';
import 'package:zephyr/features/coursedetails/service/course_details_service.dart';
import 'package:zephyr/features/payment/model/razorpay_model.dart';
import 'package:zephyr/features/payment/service/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Data _courseData = Data();
  Data get courseData => _courseData;

  double _totalPayable = 0.0;
  double get totalPayable => _totalPayable;

  void applyCouponDiscount() {}
  void removeCouponDiscount() {}

  bool _isRazorpayKeyLoading = false;
  bool get isRazorpayKeyLoading => _isRazorpayKeyLoading;

  RazorpayModel _razorpayModel = RazorpayModel();
  RazorpayModel get razorpayModel => _razorpayModel;

  Future<void> getRazorpayKey(BuildContext context) async {
    _isRazorpayKeyLoading = true;
    notifyListeners();

    final response = await PaymentService().getRazorpayKey(context: context);

    if (response == null) {
      showSnackBar("error", "Something Went Wrong!");
      _isRazorpayKeyLoading = false;
      notifyListeners();
    } else {
      if (response.isActive == true) {
        _razorpayModel = response;
        notifyListeners();

        _isRazorpayKeyLoading = false;
        notifyListeners();
      } else if (response.isActive == false) {
        _razorpayModel = response;
        notifyListeners();
        showSnackBar("error", "Something Went Wrong");

        await Future.delayed(Duration(seconds: 4), () {
          Get.offAll(BottomNavScreen());
        });

        _isRazorpayKeyLoading = false;
        notifyListeners();
      }
    }
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
        if (_courseData.discountType == "amount") {
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

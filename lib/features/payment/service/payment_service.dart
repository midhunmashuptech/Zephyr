import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/payment/model/razorpay_model.dart';

class PaymentService {
  Future<RazorpayModel?> getRazorpayKey({required BuildContext context}) async {
    final responseJson = await ApiService().getRequest(url: getRazorpayKeyUrl);
    if (responseJson == null) {
      print("Razorpay: $responseJson");
      return null;
    } else {
      print("Razorpay: $responseJson");
      final ongoingLiveModel = RazorpayModel.fromJson(responseJson);
      return ongoingLiveModel;
    }
  }
}

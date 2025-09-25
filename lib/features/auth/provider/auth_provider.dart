import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/features/auth/login/screens/login.dart';
import 'package:zephyr/features/auth/login/screens/mobile_number_verification.dart';
import 'package:zephyr/features/auth/login/screens/reset_password_login.dart';
import 'package:zephyr/features/auth/registration/model/registration_dropdown_options_model.dart'
    as dropdown_model;
import 'package:zephyr/features/auth/registration/model/verify_reset_password_model.dart';
import 'package:zephyr/features/auth/service/login_service.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:zephyr/features/auth/service/registration_service.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isVerifyingPhone = false;
  bool get isVerifyingPhone => _isVerifyingPhone;

  bool _isLogining = false;
  bool get isLogining => _isLogining;

  bool _isotpSend = false;
  bool get isOtpsend => _isotpSend;

  bool _isOtpVerified = false;
  bool get isOtpVerified => _isOtpVerified;

  String _otpStatus = "";
  String get otpStatus => _otpStatus;

  bool _isPwdReset = false;
  bool get isPwdReset => _isPwdReset;

  bool _isDropdownLoading = false;
  bool get isDropdownLoading => _isDropdownLoading;

  bool _isRegistered = false;
  bool get isregistered => _isRegistered;

  List<dropdown_model.ClassStudying> _classDropdownOptions = [];
  List<dropdown_model.ClassStudying> get classDropdownOptions =>
      _classDropdownOptions;

  List<dropdown_model.Syllabus> _syllabusDropdownOptions = [];
  List<dropdown_model.Syllabus> get syllabusDropdownOptions =>
      _syllabusDropdownOptions;

  String countryISOCode = 'IN';
  String countryCode = '';
  String phoneNumber = '';
  String errorText = '';
  bool isValidNumber = false;
  String? userExist;

  // Registration Variables
  // Registration Form Varibale
  String fullName = "";
  String dob = "";
  String email = "";
  String schoolName = "";
  int classId = 0;
  String? selectedGender = "";

  // Registration Syllabus Variable
  int? selectedSyllabusId;

  // Registration Password Variable
  String registrationPassword = "123456";

// OTP Button Enable/Disable
  bool _isOtpfilled = false;
  bool get isOtpfilled => _isOtpfilled;

  bool _isResendOtpLoading = false;
  bool get isResendOtpLoading => _isResendOtpLoading;


// inside AuthProvider

Timer? _resendTimer;
int _resendSeconds = 0;

bool get canResendOtp => _resendSeconds == 0;
int get resendSeconds => _resendSeconds;

Future<void> resendPasswordOtp({
  required BuildContext context,
  required String phoneNumber,
  required String countryCode,
}) async {
  if (!canResendOtp) return; // prevent multiple clicks

  _isResendOtpLoading = true;
  notifyListeners();

  final response = await LoginService().sendResetOtp(
    phone: phoneNumber,
    countryCode: countryCode.substring(1),
    context: context,
  );

  if (response == null) {
    showSnackBar("Error", "Error Resending Otp");
    _isResendOtpLoading = false;
    notifyListeners();
  } else {
    if (response.type == "success") {
      _otpStatus = "sent";
      debugPrint(response.otp.toString());
      showSnackBar("Otp Sent", "Successfully resent the otp");

      // ✅ Start countdown after success
      startResendTimer();

      _isResendOtpLoading = false;
      notifyListeners();
    } else {
      _otpStatus = "error";
      showSnackBar(
          "Otp Not Sent", "Something went wrong. Please try again later");
      _isResendOtpLoading = false;
      notifyListeners();
    }
  }
}

/// Start 60s timer
void startResendTimer() {
  _resendSeconds = 59;
  _resendTimer?.cancel();
  _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_resendSeconds > 0) {
      _resendSeconds--;
      notifyListeners();
    } else {
      _resendTimer?.cancel();
      notifyListeners();
    }
  });
}

@override
void dispose() {
  _resendTimer?.cancel();
  super.dispose();
}

  //  // Timer fields
  // Timer? _resendTimer;
  // int _resendSeconds = 0;

  // int get resendSeconds => _resendSeconds;
  // bool get canResendOtp => _resendSeconds == 0;

  //  /// Start a 1-minute countdown
  // void startResendTimer() {
  //   _resendSeconds = 60; // 1 min
  //   _resendTimer?.cancel();
  //   _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (_resendSeconds > 0) {
  //       _resendSeconds--;
  //       notifyListeners();
  //     } else {
  //       _resendTimer?.cancel();
  //       notifyListeners();
  //     }
  //   });
  //   notifyListeners();
  // }

  void updateOtpfilledState(bool otpfilled) {
    _isOtpfilled = otpfilled;
    notifyListeners();
  }

  void setPassword(String enterdPassword) {
    registrationPassword = enterdPassword;
    notifyListeners();
    // print(registrationPassword);
    // print(selectedSyllabusId);
    // print(fullName);
    // print(dob);
    // print(email);
    // print(schoolName);
    // print(classId);
    // print(selectedGender);
    // print(phoneNumber);
    // print(countryCode);
  }

  //registration
  Future<void> registerUser({
    required BuildContext context,
  }) async {
    _isRegistered = true;
    notifyListeners();
    final response = await RegistrationService().registerUser(context,
        name: fullName,
        email: email,
        phone: phoneNumber,
        countryCode: countryCode.substring(1),
        dob: dob,
        gender: selectedGender ?? "",
        school: schoolName,
        classStudying: classId.toString(),
        syllabus: selectedSyllabusId.toString(),
        password: registrationPassword);
    if (response == null) {
      showSnackBar("error", "Something went wrong! please try again");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contex) => MobileNumberVerification())).then((_) {
        _isRegistered = false;
        notifyListeners();
      });
    } else {
      if (response.type == "success" && response.token != null) {
        final userDetails = response.user;
        final userDetailProvider = context.read<UserDetailsProvider>();
        userDetailProvider.setUserDetails(userDetails ?? User());
        await _secureStorage.write(key: "loginedOnce", value: "true");
        await _secureStorage.write(key: "token", value: response.token);
        showSnackBar("Registration success", "Start your journey now");
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavScreen()))
            .then((_) {
          _isRegistered = false;
          notifyListeners();
        });
      } else {
        showSnackBar("Registration failed", "Please try again later");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => MobileNumberVerification())).then((_) {
          _isRegistered = false;
          notifyListeners();
        });
      }
    }
  }

  // Login Variables
  bool _isPasswordEmpty = false;
  bool get isPasswordEmpty => _isPasswordEmpty;
  String password = '';

  void setSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void clearSyllabus() {
    selectedSyllabusId = null;
  }

  void setSelectedSyllabus(int? syllabusId) {
    _isRegistered = false;
    selectedSyllabusId = syllabusId;
    notifyListeners();
  }

  void setGenderNull() {
    selectedGender = null;
    notifyListeners();
  }

  void setAllFormValues(String nameValue, String dobValue, String emailValue,
      String schoolNameValue, int classIdValue) {
    fullName = nameValue;
    dob = dobValue;
    email = emailValue;
    schoolName = schoolNameValue;
    classId = classIdValue;

    debugPrint(
        "$nameValue $dobValue $emailValue $schoolNameValue $schoolNameValue $classIdValue $selectedGender");
  }

  void updatePasswordStatus(bool value, String typedPassword) {
    _isPasswordEmpty = value;
    password = typedPassword;
    notifyListeners();
  }

  /// Update phone number & validate
  void updatePhoneNumber(PhoneNumber value) {
    countryISOCode = value.countryISOCode;
    countryCode = value.countryCode;
    phoneNumber = value.number;

    if (phoneNumber.isEmpty) {
      errorText = "Mobile number is required";
      isValidNumber = false;
    } else if (!value.isValidNumber()) {
      errorText = "Enter a valid mobile number";
      isValidNumber = false;
    } else {
      errorText = '';
      isValidNumber = true;
    }

    notifyListeners();
  }

  Future<void> userLogin(BuildContext context, String password) async {
    _isLogining = true;
    debugPrint("true $isLogining");
    notifyListeners();

    final response = await LoginService().login(context,
        countryCode: countryCode, phone: phoneNumber, password: password);
    if (response == null) {
      debugPrint("Something went wrong! please try again");
      _isLogining = false;
      notifyListeners();
    } else {
      if (response.type == "success" &&
          response.token != null &&
          response.token != "") {
        // Writing token to Flutter secure Storage
        await _secureStorage.write(key: "token", value: response.token);
        await _secureStorage.write(key: "loginedOnce", value: "true");

        // Reading token from Flutter secure Storage
        final token = await _secureStorage.read(key: "token");

        context
            .read<UserDetailsProvider>()
            .setUserDetails(response.user ?? User());

        print(token);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => BottomNavScreen()),);
        Get.offAll(BottomNavScreen())?.then((value) {
          _isLogining = false;
          notifyListeners();
        });
      } else {
        _isLogining = false;
        notifyListeners();
      }
    }
  }

  Future<void> verifyPhoneNumber(
      BuildContext context, String phone, String countryCode) async {
    _isVerifyingPhone = true;
    notifyListeners();

    final response = await LoginService()
        .verifyPhoneNumber(context, countryCode: countryCode, phone: phone);
    if (response == null) {
      userExist == "error";
    } else {
      print(response.exists);
      if (response.exists == true) {
        userExist = "true";
      } else if (response.exists == false) {
        userExist = "false";
      }
    }
    notifyListeners();

    _isVerifyingPhone = false;
    _isPasswordEmpty = false;
    password = '';
    notifyListeners();
  }

  Future<void> fetchRegisrationDropdownOption() async {
    _isDropdownLoading = true;
    selectedGender = "";
    notifyListeners();

    final response = await RegistrationService().getRegisterDropdownOptions();
    if (response == null) {
      showSnackBar("Error", "Something went wrong! Try again");
    } else {
      if (response.type == "success") {
        _classDropdownOptions = response.classStudying ?? [];
        _syllabusDropdownOptions = response.syllabuses ?? [];
        print("Syllabus: ${syllabusDropdownOptions.length}");
      } else {
        _classDropdownOptions = [];
        _syllabusDropdownOptions = [];
      }
    }
    notifyListeners();

    _isDropdownLoading = false;
    notifyListeners();
  }

  //Reset Password
  Future<void> resetPassword(
      {required BuildContext context, required String password}) async {
    _isPwdReset = true;
    notifyListeners();
    final response = await LoginService().resetPassword(
        context: context,
        phone: phoneNumber,
        countryCode: countryCode,
        password: password);
    if (response == null) {
      showSnackBar("error", "Failed to reset Password");
      _isPwdReset = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        showSnackBar("success", "password reset successful");
        print(countryCode);
        print(phoneNumber);
        Get.offAll(Login(
            phoneNumber: phoneNumber,
            countryCode: countryCode,
            isoCode: countryISOCode));
        _isPwdReset = false;
        notifyListeners();
      }
    }
  }

  //Send Otp Reset Password
  Future<void> resetPasswordSendOtp({required BuildContext context}) async {
    _isotpSend = true;
    _isOtpfilled = false;
    notifyListeners();
    final response = await LoginService().sendResetOtp(
        phone: phoneNumber,
        countryCode: countryCode.substring(1),
        context: context);
    if (response == null) {
      showSnackBar("Error", "Error Sending Otp");
      _isotpSend = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _otpStatus = "sent";
        debugPrint(response.otp.toString());
        showSnackBar("Otp Sent", "successfully sent the otp");
        _isotpSend = false;
        notifyListeners();
      } else {
        _otpStatus = "error";
        showSnackBar(
            "Otp Not Sent", "Something went wrong.Please try again later");
        _isotpSend = false;
        notifyListeners();
      }
    }
  }

  // //Resend Otp
  // Future<void> resendPasswordOtp({required BuildContext context}) async {
  //   _isResendOtpLoading = true;
  //   notifyListeners();
  //   // _isOtpfilled = false;
  //   final response = await LoginService().sendResetOtp(
  //       phone: phoneNumber,
  //       countryCode: countryCode.substring(1),
  //       context: context);
  //   if (response == null) {
  //     showSnackBar("Error", "Error Resending Otp");
  //     _isResendOtpLoading = false;
  //     notifyListeners();
  //   } else {
  //     if (response.type == "success") {
  //       _otpStatus = "sent";
  //       debugPrint(response.otp.toString());
  //       showSnackBar("Otp Sent", "successfully Resend the otp");
  //       _isResendOtpLoading = false;
  //       notifyListeners();
  //     } else {
  //       _otpStatus = "error";
  //       showSnackBar(
  //           "Otp Not Sent", "Something went wrong.Please try again later");
  //       _isResendOtpLoading = false;
  //       notifyListeners();
  //     }
  //   }
  // }

  //Verify Reset Password Otp
  Future<VerifyResetPasswordModel?> verifyPasswordOtp(
      {required BuildContext context, required String otp}) async {
    _isOtpVerified = true;
    notifyListeners();
    final response = await LoginService().verifyResetOtp(
        phone: phoneNumber,
        countryCode: countryCode.substring(1),
        otp: otp,
        context: context);
    if (response == null) {
      _isOtpVerified = false;
      notifyListeners();
      showSnackBar("Error", "Verification Error");
      return null;
    } else {
      if (response.type == "success") {
        showSnackBar("Otp Verified", "Successfully verified otp");
        _otpStatus = "success";
        _isOtpVerified = false;
        notifyListeners();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResetPasswordLogin()));
      } else if (response.type == "error") {
        _otpStatus = "invalid";
        _isOtpVerified = false;
        notifyListeners();
        showSnackBar("Otp Verification Failed",
            "Invalid otp.Please try again or resend otp");
      } else {
        _otpStatus = "error";
        _isOtpVerified = false;
        notifyListeners();
        showSnackBar("Error", "Something went wrong");
      }
    }
    return null;
  }
}

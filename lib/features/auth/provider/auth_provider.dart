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
import 'package:zephyr/features/auth/registration/model/verify_registration_otp_model.dart';
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

  Timer? _resendTimer;
  int _resendSeconds = 0;

  bool get canResendOtp => _resendSeconds == 0;
  int get resendSeconds => _resendSeconds;

  @override
  void dispose() {
    _resendTimer?.cancel();
    _regResendTimer?.cancel();
    super.dispose();
  }


  void setPassword(String enterdPassword) {
    registrationPassword = enterdPassword;
    notifyListeners();
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

  //Resend Password OTP
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

  ////Registration OTP////

//loading variable
  bool _isRegOtpSending = false;
  bool get isRegOtpSending => _isRegOtpSending;

  bool _isRegOtpVerifying = false;
  bool get isRegOtpVerifying => _isRegOtpVerifying;

  // OTP Button Enable/Disable
  bool _isRegOtpfilled = false;
  bool get isRegOtpfilled => _isRegOtpfilled;
  
  void updateOtpfilledState(bool otpfilled) {
    _isOtpfilled = otpfilled;
    notifyListeners();
  }


//Timer variable
  Timer? _regResendTimer;
  int _regResendSeconds = 0;

//Otp Status variable
  bool _isRegOtpVerified = false;
  bool get isRegOtpVerified => _isRegOtpVerified;

  bool get canRegResendOtp => _regResendSeconds == 0;
  int get regresendSeconds => _regResendSeconds;

  /// Timer for registration OTP
  void regResendTimer() {
    _regResendSeconds = 59;
    _regResendTimer?.cancel();
    _regResendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_regResendSeconds > 0) {
        _regResendSeconds--;
        notifyListeners();
      } else {
        _regResendTimer?.cancel();
        notifyListeners();
      }
    });
  }

  void updateRegOtpfilledState(bool isRegOtpfilled) {
    _isRegOtpfilled = isRegOtpfilled;
    notifyListeners();
  }

  bool _isResendRegOtpLoading = false;
  bool get isResetRegOtpLoading => _isResendRegOtpLoading;

  //ReSend Registration OTP
  Future<void> resendRegOtp({required BuildContext context}) async {
    if (!canRegResendOtp) return;
    _isResendRegOtpLoading = true;
    notifyListeners();
    final response = await RegistrationService().sendRegistrationOtp(
        context: context,
        phone: phoneNumber,
        countryCode: countryCode.substring(1));
    if (response == null) {
      _isResendRegOtpLoading = false;
      notifyListeners();
      showSnackBar("Error", "Couldnt Sent OTP");
    } else {
      if (response.type == "success") {
        debugPrint(response.otp.toString());
        showSnackBar("Otp Sent", "Successfully resent the otp");
        // ✅ Start countdown after success
        regResendTimer();
        _isResendRegOtpLoading = false;
        notifyListeners();
      }
    }
  }

  //send Registration OTP
  Future<void> sendRegOtp({required BuildContext context}) async {
    _isRegOtpfilled = false;
    _isRegOtpVerified = false;
    _isRegOtpSending = true;
    notifyListeners();
    final response = await RegistrationService().sendRegistrationOtp(
        context: context,
        phone: phoneNumber,
        countryCode: countryCode.substring(1));
    if (response == null) {
      _isRegOtpSending = false;
      notifyListeners();
      showSnackBar("Error", "Something went wrong");
    } else {
      if (response.type == "success") {
        debugPrint(response.otp.toString());
        _isRegOtpSending = false;
        notifyListeners();
        showSnackBar("Success", "We've Sent an OTP to your mobile number");
      }
    }
  }

  //Verify Registration OTP
  Future<void> verifyRegOtp(
      {required BuildContext context, required String otp}) async {
    _isRegOtpVerifying = true;
    _isRegOtpVerified = false;
    notifyListeners();
    final response = await RegistrationService().verifyRegistrationOtp(
        phone: phoneNumber,
        countryCode: countryCode,
        otp: otp,
        context: context);
    if (response == null) {
      _isRegOtpVerified = false;
      _isRegOtpVerifying = false;
      notifyListeners();
      showSnackBar("Error", "Verification Error");
    } else {
      if (response.type == "success") {
        showSnackBar("Success", "Successfully verified Registration OTP");
        _isRegOtpVerified = true;
        _isRegOtpVerifying = false;
        notifyListeners();
      } else {
        showSnackBar("Error", "Error Verifying Registration OTP");
        _isRegOtpVerifying = false;
        _isRegOtpVerified = false;
        notifyListeners();
      }
    }
  }
}

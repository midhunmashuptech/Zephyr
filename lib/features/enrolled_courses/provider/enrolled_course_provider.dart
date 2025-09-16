import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/model/get_course_reviews_model.dart';
import 'package:zephyr/features/coursedetails/service/course_details_service.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_detail_model.dart'
    as enrolledCourseDetailsModel;
import 'package:zephyr/features/enrolled_courses/model/course_enrollments_model.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_model.dart';
import 'package:zephyr/features/enrolled_courses/service/enrolled_course_service.dart';

class EnrolledCourseProvider extends ChangeNotifier {
  bool _isChapterLoading = false;
  bool get isChapterLoading => _isChapterLoading;

  List<String> _chapterList = [];
  List<String> get chapterList => _chapterList;

  bool _isCourseLoading = false;
  bool get isCourseLoading => _isCourseLoading;

  // Reviews
  bool _isReviewsLoading = false;
  bool get isReviewsLoading => _isReviewsLoading;

  List<Reviews> _courseReviews = [];
  List<Reviews> get courseReviews => _courseReviews;

  bool _isReviewPosting = false;
  bool get isReviewPosting => _isReviewPosting;

  bool _isReviewPostingSuccess = false;
  bool get isReviewPostingSuccess => _isReviewPostingSuccess;

  String? userRating;
  String? userReview;

  ReviewDetails? myReview;

  void clearUserRatingDetails() {
    userRating = null;
    userReview = null;
    myReview = null;
    notifyListeners();
  }

  void setUserRating(int rating) {
    userRating = rating.toString();
    notifyListeners();
  }

  void setUserReview(String review) {
    userReview = review;
    notifyListeners();
  }

  void setMyReview(BuildContext context) {
    final userDetailsProvider =
        Provider.of<UserDetailsProvider>(context, listen: false);
    final result = courseReviews.firstWhere(
      (review) => review.userId == userDetailsProvider.userDetails.id,
      orElse: () => Reviews(id: -1),
    );
    print(result.id);
    if (result.id != -1) {
      print("My Review available!");
      _isReviewPostingSuccess = true;
      myReview = ReviewDetails(
          userName: userDetailsProvider.userDetails.name ?? "My Name",
          userImage: userDetailsProvider.userDetails.image ?? "",
          reviewText: result.review ?? "",
          timeAgo: result.createdAt.toString(),
          rating: (result.rating ?? 0).toDouble());
    }
    notifyListeners();
  }

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
  bool _isCourseEnrollmentsLoading = false;
  bool get isCourseEnrollmentsLoading => _isCourseEnrollmentsLoading;

  List<Enrollments> _courseEnrollments = [];
  List<Enrollments> get courseEnrollments => _courseEnrollments;

  Enrollments _selectedEnrollment = Enrollments();
  Enrollments get selectedEnrollment => _selectedEnrollment;

  void changeEnrollment(int enrollmentId) {
    _selectedEnrollment = courseEnrollments.firstWhere(
        (enrollment) => enrollment.enrollmentId == enrollmentId,
        orElse: () => courseEnrollments[0]);
    notifyListeners();
  }

  bool _isCourseDetailsLoading = false;
  bool get isCourseDetailsLoading => _isCourseDetailsLoading;

  enrolledCourseDetailsModel.Data _selectedCourseDetails = enrolledCourseDetailsModel.Data();
  enrolledCourseDetailsModel.Data get selectedCourseDetails => _selectedCourseDetails;

  List<enrolledCourseDetailsModel.Chapters> getChapters(int index) {
    return (selectedCourseDetails.subjects ?? [])[index].chapters ?? [];
  }

  Future<void> getCourseDetailsAndEnrollments(
      {required BuildContext context, required String courseId}) async {
    await getCourseEnrollments(context, courseId);
    await getCourseDetails(context, courseId);
  }

  Future<void> getCourseEnrollments(
      BuildContext context, String courseId) async {
    _isCourseEnrollmentsLoading = true;
    notifyListeners();

    final response = await EnrolledCourseService()
        .getCourseEnrollments(context, courseId: courseId);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _courseEnrollments = response.enrollments ?? [];
        notifyListeners();
        _selectedEnrollment = _courseEnrollments[0];
      } else {
        _courseEnrollments = [];
      }
    }
    notifyListeners();
    _isCourseEnrollmentsLoading = false;
    notifyListeners();
  }

  Future<void> getCourseDetails(BuildContext context, String courseId) async {
    _isCourseDetailsLoading = true;
    notifyListeners();

    final response = await EnrolledCourseService()
        .getEnrolledCourseDetails(context: context, courseId: courseId);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _selectedCourseDetails = response.data ?? enrolledCourseDetailsModel.Data();
      } else {
        _selectedCourseDetails = enrolledCourseDetailsModel.Data();
      }
    }
    notifyListeners();
    _isCourseDetailsLoading = false;
    notifyListeners();
  }

  // Get Course Review
  Future<void> getCourseReviews(
      {required String courseId, required BuildContext context}) async {
    _isReviewsLoading = true;
    _isReviewPostingSuccess = false;
    clearUserRatingDetails();
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
        setMyReview(context);
        _isReviewsLoading = false;
        notifyListeners();
      } else {
        showSnackBar("error", "something went wrong");
        _isReviewsLoading = false;
        notifyListeners();
      }
    }
  }

  // Post Course Review
  Future<void> postCourseReviews(
      {required String courseId, required BuildContext context}) async {
    _isReviewPosting = true;
    notifyListeners();

    final response = await EnrolledCourseService().postCourseReview(
        context: context,
        courseId: courseId,
        rating: userRating ?? "0",
        review: userReview ?? "");

    if (response == null) {
      showSnackBar("error", "something went wrong");
      _isReviewPosting = false;
      _isReviewPostingSuccess = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _isReviewPostingSuccess = true;
        final userDetailsProvider =
            Provider.of<UserDetailsProvider>(context, listen: false);
        myReview = ReviewDetails(
            userName: userDetailsProvider.userDetails.name ?? "My Name",
            userImage: userDetailsProvider.userDetails.image ?? "",
            reviewText: userReview ?? "",
            timeAgo: DateFormat('yyyy.MM.dd').format(DateTime.now()),
            rating: double.parse(userRating ?? "0.0"));
        notifyListeners();
        _isReviewPosting = false;
        notifyListeners();
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(17)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset("assets/lottie/review.json",
                          height: 300, width: 300),
                      Text(
                        "Thank You for Your Review!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(
                        "We appreciate you taking the time to share your feedback. Your input helps us improve and inspire more learners.",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: AppColors.black),
                                ),
                              )))
                    ],
                  ),
                ),
              ));
            });
      } else {
        showSnackBar("error", "something went wrong");
        _isReviewPosting = false;
        notifyListeners();
      }
    }
  }
}

class ReviewDetails {
  final String userName;
  final String userImage;
  String reviewText;
  final String timeAgo;
  double rating;

  ReviewDetails({
    required this.userName,
    required this.userImage,
    required this.reviewText,
    required this.timeAgo,
    required this.rating,
  });
}

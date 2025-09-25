import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/common/widgets/rating_star_widget.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/model/get_course_reviews_model.dart';
import 'package:zephyr/features/coursedetails/widgets/rating_widget.dart';
import 'package:zephyr/features/coursedetails/widgets/review_card.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/enrolled_courses/widgets/my_review_card.dart';
import 'package:zephyr/features/auth/login/widgets/custom_textfeild.dart';

class EnrolledCoursesReview extends StatefulWidget {
  final String courseId;
  const EnrolledCoursesReview({super.key, required this.courseId});

  @override
  State<EnrolledCoursesReview> createState() => _EnrolledCoursesReviewState();
}

class _EnrolledCoursesReviewState extends State<EnrolledCoursesReview> {
  EnrolledCourseProvider enrolledCourseProvider = EnrolledCourseProvider();
  bool isReviewSubmitted = false;
  final reviewController = TextEditingController();

  double calculateEachRatingPercent(List<Reviews> courseReviews, int rating) {
    final ratingList =
        courseReviews.where((review) => review.rating == rating).toList();
    debugPrint("${ratingList.length / courseReviews.length}");
    return ratingList.length / courseReviews.length;
  }

  String convertToTimeAgo(String isoDate) {
    if (isoDate.isEmpty) return "";
    if (isoDate == "") return "";

    try {
      DateTime date = DateTime.parse(isoDate);
      DateTime now = DateTime.now().toUtc();
      Duration diff = now.difference(date);

      if (diff.inDays < 1) {
        return "Today";
      } else if (diff.inDays == 1) {
        return "1 day ago";
      } else if (diff.inDays < 7) {
        return "${diff.inDays} days ago";
      } else if (diff.inDays < 30) {
        int weeks = (diff.inDays / 7).floor();
        return weeks == 1 ? "1 week ago" : "$weeks weeks ago";
      } else if (diff.inDays < 365) {
        int months = (diff.inDays / 30).floor();
        return months == 1 ? "1 month ago" : "$months months ago";
      } else {
        int years = (diff.inDays / 365).floor();
        return years == 1 ? "1 year ago" : "$years years ago";
      }
    } catch (e) {
      return "";
    }
  }

  Future<void> loadReviews() async {
    final loadProvider = context.read<EnrolledCourseProvider>();
    await loadProvider.getCourseReviews(
        courseId: widget.courseId, context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    loadReviews();
  });
   
  }

  @override
  Widget build(BuildContext context) {
    enrolledCourseProvider = context.watch<EnrolledCourseProvider>();
    return Scaffold(
      body: enrolledCourseProvider.isReviewsLoading
          ? Center(child: CircularProgressIndicator())
          : enrolledCourseProvider.courseReviews.isEmpty
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Lottie.asset("assets/lottie/no_comments.json",
                          height: 200),
                      Text("No Reviews Yet!"),
                    ],
                  ),
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grey.withAlpha(70),
                                    spreadRadius: 3,
                                    blurRadius: 5)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    RatingBarWidget(
                                        number: "5",
                                        value: calculateEachRatingPercent(
                                            enrolledCourseProvider
                                                .courseReviews,
                                            5)),
                                    RatingBarWidget(
                                        number: "4",
                                        value: calculateEachRatingPercent(
                                            enrolledCourseProvider
                                                .courseReviews,
                                            4)),
                                    RatingBarWidget(
                                        number: "3",
                                        value: calculateEachRatingPercent(
                                            enrolledCourseProvider
                                                .courseReviews,
                                            3)),
                                    RatingBarWidget(
                                        number: "2",
                                        value: calculateEachRatingPercent(
                                            enrolledCourseProvider
                                                .courseReviews,
                                            2)),
                                    RatingBarWidget(
                                        number: "1",
                                        value: calculateEachRatingPercent(
                                            enrolledCourseProvider
                                                .courseReviews,
                                            1)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        enrolledCourseProvider
                                            .selectedCourseDetails.averageRating
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      RatingStarWidget(
                                        rating: enrolledCourseProvider
                                                .selectedCourseDetails
                                                .averageRating ??
                                            0.0,
                                      ),
                                      Text(
                                          "${enrolledCourseProvider.selectedCourseDetails.ratingCount} reviews")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grey.withAlpha(70),
                                    spreadRadius: 3,
                                    blurRadius: 5)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:
                                enrolledCourseProvider.isReviewPostingSuccess &&
                                        enrolledCourseProvider.myReview != null
                                    ? MyReviewCard(
                                        userName: enrolledCourseProvider
                                                .myReview?.userName ??
                                            "",
                                        userImage: enrolledCourseProvider
                                                .myReview?.userImage ??
                                            "",
                                        reviewText: enrolledCourseProvider
                                                .myReview?.reviewText ??
                                            "",
                                        rating: enrolledCourseProvider
                                                .myReview?.rating ??
                                            0.0)
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Text("Rate this course",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  enrolledCourseProvider
                                                      .setUserRating(
                                                          rating.toInt());
                                                  debugPrint(rating.toString());
                                                },
                                              ),
                                              Text(
                                                "${(enrolledCourseProvider.userRating ?? 0)}.0",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text("Write your review"),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CustomTextField(
                                            controller: reviewController,
                                            maxLines: 3,
                                            hintText:
                                                "write about your experience with the course......",
                                          ),
                                          enrolledCourseProvider.isReviewPosting
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color:
                                                        AppColors.primaryGreen,
                                                  )),
                                                )
                                              : CustomButton(
                                                  text: "Submit your review",
                                                  color: AppColors.primaryGreen,
                                                  textcolor: AppColors.white,
                                                  onPressed:
                                                      enrolledCourseProvider
                                                                  .userRating ==
                                                              null
                                                          ? null
                                                          : () async {
                                                              enrolledCourseProvider
                                                                  .setUserReview(
                                                                      reviewController
                                                                          .text);

                                                              // setState(() {
                                                              //   isReviewSubmitted = true;
                                                              //   myReviews.reviewText =
                                                              //       reviewController.text;
                                                              // });

                                                              enrolledCourseProvider
                                                                  .postCourseReviews(
                                                                      courseId:
                                                                          "1",
                                                                      context:
                                                                          context);
                                                            },
                                                )
                                        ],
                                      ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Divider(),
                        ),
                        ...List.generate(
                            enrolledCourseProvider.courseReviews.length,
                            (index) => ReviewCard(
                                  userName: enrolledCourseProvider
                                          .courseReviews[index].user?.name ??
                                      "No Name",
                                  userImage: enrolledCourseProvider
                                          .courseReviews[index].user?.image ??
                                      "",
                                  reviewText: enrolledCourseProvider
                                          .courseReviews[index].review ??
                                      "",
                                  timeAgo: convertToTimeAgo(
                                      enrolledCourseProvider
                                              .courseReviews[index].createdAt ??
                                          ""),
                                  rating: double.parse(enrolledCourseProvider
                                      .courseReviews[index].rating
                                      .toString()),
                                )),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}

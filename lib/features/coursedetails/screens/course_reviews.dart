import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/widgets/rating_star_widget.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/model/get_course_reviews_model.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/coursedetails/widgets/rating_widget.dart';
import 'package:zephyr/features/coursedetails/widgets/review_card.dart';

class CourseReviews extends StatefulWidget {
  const CourseReviews({super.key});

  @override
  State<CourseReviews> createState() => _CourseReviewsState();
}

class _CourseReviewsState extends State<CourseReviews> {
  CourseProvider courseProvider = CourseProvider();

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  double calculateEachRatingPercent(List<Reviews> courseReviews, int rating) {
    final ratingList =
        courseReviews.where((review) => review.rating == rating).toList();
    print(ratingList.length / courseReviews.length);
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
    final loadProvider = context.read<CourseProvider>();
    await loadProvider.getCourseReviews(courseId: "1", context: context);
  }

  @override
  Widget build(BuildContext context) {
    courseProvider = context.watch<CourseProvider>();
    return Scaffold(
      body: courseProvider.isReviewsLoading
          ? Center(child: CircularProgressIndicator())
          : courseProvider.courseReviews.isEmpty
              ? Center(
                  child: Text("No Reviews Found!"),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                                            courseProvider.courseReviews, 5)),
                                    RatingBarWidget(
                                        number: "4",
                                        value: calculateEachRatingPercent(
                                            courseProvider.courseReviews, 4)),
                                    RatingBarWidget(
                                        number: "3",
                                        value: calculateEachRatingPercent(
                                            courseProvider.courseReviews, 3)),
                                    RatingBarWidget(
                                        number: "2",
                                        value: calculateEachRatingPercent(
                                            courseProvider.courseReviews, 2)),
                                    RatingBarWidget(
                                        number: "1",
                                        value: calculateEachRatingPercent(
                                            courseProvider.courseReviews, 1)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        courseProvider.courseData.averageRating
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      RatingStarWidget(
                                        rating: courseProvider
                                                .courseData.averageRating ??
                                            0.0,
                                      ),
                                      Text(
                                          "${courseProvider.courseData.ratingCount} reviews")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        ...List.generate(
                            courseProvider.courseReviews.length,
                            (index) => ReviewCard(
                                  userName: (courseProvider
                                          .courseReviews[index].user?.name ??
                                      "Unknown User"),
                                  userImage: courseProvider
                                          .courseReviews[index].user?.image ??
                                      "",
                                  reviewText: courseProvider
                                          .courseReviews[index].review ??
                                      "",
                                  timeAgo: convertToTimeAgo(courseProvider
                                          .courseReviews[index].createdAt ??
                                      ""),
                                  rating: double.parse(courseProvider
                                      .courseReviews[index].rating
                                      .toString()),
                                )),
                        // SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}

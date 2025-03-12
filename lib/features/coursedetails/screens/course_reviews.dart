import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/widgets/rating_widget.dart';
import 'package:zephyr/features/coursedetails/widgets/review_card.dart';

class CourseReviews extends StatefulWidget {
  const CourseReviews({super.key});

  @override
  State<CourseReviews> createState() => _CourseReviewsState();
}

class _CourseReviewsState extends State<CourseReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          RatingWidget(number: "5", value: 0.9),
                          RatingWidget(number: "4", value: 0.7),
                          RatingWidget(number: "3", value: 0.6),
                          RatingWidget(number: "2", value: 0.5),
                          RatingWidget(number: "1", value: 0.4),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Text(
                              "4.8",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.primaryOrange,
                                  size: 15,
                                ),
                              ],
                            ),
                            Text("70 reviews")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ReviewCard(
                  userName: "Athulya Ajayakumar",
                  userImage: "assets/images/yaami.jpg",
                  reviewText:
                      "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.",
                  timeAgo: "15 min ago"),
              ReviewCard(
                  userName: "Anaswara Venu",
                  userImage: "assets/images/yaami.jpg",
                  reviewText:
                      "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.",
                  timeAgo: "50 min ago"),
              ReviewCard(
                  userName: "Midhun Murali",
                  userImage: "assets/images/yaami.jpg",
                  reviewText:
                      "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.",
                  timeAgo: "1hr ago"),
              ReviewCard(
                  userName: "Dony Baby",
                  userImage: "assets/images/yaami.jpg",
                  reviewText:
                      "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.",
                  timeAgo: "1hr 30 min ago"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

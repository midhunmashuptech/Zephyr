import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/common/widgets/rating_star_widget.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/widgets/rating_widget.dart';
import 'package:zephyr/features/coursedetails/widgets/review_card.dart';
import 'package:zephyr/features/enrolled_courses/widgets/my_review_card.dart';
import 'package:zephyr/features/login/widgets/custom_textfeild.dart';

class EnrolledCoursesReview extends StatefulWidget {
  const EnrolledCoursesReview({super.key});

  @override
  State<EnrolledCoursesReview> createState() => _EnrolledCoursesReviewState();
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

class _EnrolledCoursesReviewState extends State<EnrolledCoursesReview> {
  bool isReviewSubmitted = false;
  final reviewController = TextEditingController();
  ReviewDetails myReviews = ReviewDetails(
      userName: "Athulya",
      userImage: "assets/images/yaami.jpg",
      reviewText: "",
      timeAgo: "",
      rating: 0.0);
  List<ReviewDetails> reviewDetails = [
    ReviewDetails(
        userName: "Alankara Nair",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "The foundation course made science and math so easy to understand. The videos are fun, and the quizzes really help me test what I learned!",
        timeAgo: "3 day ago",
        rating: 5.0),
    ReviewDetails(
        userName: "Meenakshi KS",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "Helped improve my marks!”.My marks improved in all subjects after I joined this course. The foundation it builds is perfect for Class 9 and beyond.",
        timeAgo: "30 min ago",
        rating: 4.6),
    ReviewDetails(
        userName: "Suresh Krishna",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "Best Online class ever!.I was struggling with algebra and physics, but this course explained everything so clearly. Now, I feel more confident before exams.",
        timeAgo: "8 day ago",
        rating: 5.0),
    ReviewDetails(
        userName: "Meenakshi",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "Great support and material.The notes, video lessons, and practice tests are excellent. I also love how I can go back and watch lessons again whenever I want.",
        timeAgo: "8 day ago",
        rating: 5.0),
    ReviewDetails(
        userName: "Alankara Nair",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "The foundation course made science and math so easy to understand. The videos are fun, and the quizzes really help me test what I learned!",
        timeAgo: "3 day ago",
        rating: 5.0),
    ReviewDetails(
        userName: "Meenakshi KS",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "Helped improve my marks!”.My marks improved in all subjects after I joined this course. The foundation it builds is perfect for Class 9 and beyond.",
        timeAgo: "30 min ago",
        rating: 5.0),
    ReviewDetails(
        userName: "Suresh Krishna",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "Best Online class ever!.I was struggling with algebra and physics, but this course explained everything so clearly. Now, I feel more confident before exams.",
        timeAgo: "8 day ago",
        rating: 5.0),
    ReviewDetails(
        userName: "Meenakshi",
        userImage: "assets/images/yaami.jpg",
        reviewText:
            "Great support and material.The notes, video lessons, and practice tests are excellent. I also love how I can go back and watch lessons again whenever I want.",
        timeAgo: "8 day ago",
        rating: 5.0),
  ];
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
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          RatingBarWidget(number: "5", value: 0.9),
                          RatingBarWidget(number: "4", value: 0.7),
                          RatingBarWidget(number: "3", value: 0.6),
                          RatingBarWidget(number: "2", value: 0.5),
                          RatingBarWidget(number: "1", value: 0.4),
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
                            RatingStarWidget(
                              rating: 3.5,
                            ),
                            Text("70 reviews")
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
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isReviewSubmitted
                      ? MyReviewCard(
                          userName: myReviews.userName,
                          userImage: myReviews.userImage,
                          reviewText: myReviews.reviewText,
                          rating: myReviews.rating)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text("Rate this course",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500))),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                    setState(() {
                                      myReviews.rating = rating;
                                    });
                                  },
                                ),
                                Text(myReviews.rating.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),)
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                            CustomButton(
                              text: "Submit your review",
                              color: AppColors.primaryGreen,
                              textcolor: AppColors.white,
                              onPressed: myReviews.rating == 0.0
                              ? null
                              : () {
                                setState(() {
                                  isReviewSubmitted = true;
                                  myReviews.reviewText = reviewController.text;
                                });
                              },
                            )
                          ],
                        ),
                ),
              ),
              ...List.generate(
                  reviewDetails.length,
                  (index) => ReviewCard(
                        userName: reviewDetails[index].userName,
                        userImage: reviewDetails[index].userImage,
                        reviewText: reviewDetails[index].reviewText,
                        timeAgo: reviewDetails[index].timeAgo,
                        rating: reviewDetails[index].rating,
                      )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

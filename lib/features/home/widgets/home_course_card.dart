import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/home/model/category_based_course_model.dart';

class HomeCourseCard extends StatelessWidget {
  final int index;
  final String courseId;
  final String courseName;
  final String courseRating;
  final String thumbnail;

  const HomeCourseCard(
      {super.key,
      required this.index,
      required this.courseId,
      required this.courseName,
      required this.courseRating,
      required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("ID: " + courseId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetailsScreen(
                      courseId: courseId,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          color: AppColors.white,
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.25,
                    width: double.infinity, // takes full width of parent (Card)
                    child: CachedNetworkImage(
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Shimmer.fromColors(
                        baseColor: AppColors.grey,
                        highlightColor: AppColors.lightGrey,
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            switch (index % 3) {
                              0 => AppColors.primaryBlue,
                              1 => AppColors.primaryGreen,
                              2 => AppColors.primaryOrange,
                              int() => AppColors.black,
                            },
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(bottom: 10, right: 20, child: courseStarRating()),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(courseName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                    // SizedBox(
                    //   height: 43,
                    //   child: Text(course.description ?? "",
                    //       style: TextStyle(fontSize: 13),
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 2,),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget courseStarRating() {
    double rating = double.parse(courseRating);
    final fullStarCount = rating.floor();
    final decimalPart = rating - fullStarCount;
    final halfStarCount = decimalPart >= 0.5 ? 1 : 0;
    final emptyStarCount = 5 - fullStarCount - halfStarCount;

    return Row(
      children: [
        ...List.generate(fullStarCount, (index) {
          return Icon(Icons.star, size: 18, color: AppColors.ratingYellow);
        }),
        ...List.generate(halfStarCount, (index) {
          return Icon(Icons.star_half, size: 18, color: AppColors.ratingYellow);
        }),
        ...List.generate(emptyStarCount, (index) {
          return Icon(Icons.star_outline,
              size: 18, color: AppColors.ratingYellow);
        }),
        SizedBox(width: 5),
        Text("3.2",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppColors.white))
      ],
    );
  }
}

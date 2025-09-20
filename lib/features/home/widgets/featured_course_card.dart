import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_detail_screen.dart';
import 'package:zephyr/features/home/model/featured_course_model.dart';

class FeaturedCourseCard extends StatelessWidget {
  final int index;
  final Courses course;
  const FeaturedCourseCard(
      {super.key, required this.course, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        course.isEnrolled == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EnrolledCourseDetailScreen(
                          courseId: course.id.toString(),
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CourseDetailsScreen(
                          courseId: course.id.toString(),
                        )));
      },
      child: Card(
        color: AppColors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: SizedBox(
                    height: 120,
                    child: CachedNetworkImage(
                      imageUrl: course.thumbnail ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title ?? "Course Title",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget courseStarRating() {
    double rating = course.averageRating ?? 0.0;
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
        Text("${course.averageRating ?? 0.0}",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppColors.white))
      ],
    );
  }
}

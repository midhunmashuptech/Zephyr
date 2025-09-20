import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_detail_screen.dart';

class HomeCourseCard extends StatelessWidget {
  final int index;
  final String courseId;
  final String courseName;
  final String courseRating;
  final String thumbnail;
  final bool isEnrolled;

  const HomeCourseCard(
      {super.key,
      required this.index,
      required this.courseId,
      required this.courseName,
      required this.courseRating,
      required this.thumbnail,
      required this.isEnrolled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("ID: $courseId");
        isEnrolled
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EnrolledCourseDetailScreen(
                          courseId: courseId,
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CourseDetailsScreen(
                          courseId: courseId,
                        )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.30),
        color: AppColors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
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
                ),
                // Gradient overlay for readability
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          switch (index % 3) {
                            0 => AppColors.primaryBlue.withOpacity(0.85),
                            1 => AppColors.primaryGreen.withOpacity(0.85),
                            2 => AppColors.primaryOrange.withOpacity(0.85),
                            int() => AppColors.black.withOpacity(0.85),
                          },
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Enroll/Enrolled badge
                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isEnrolled
                          ? AppColors.primaryGreen.withOpacity(0.9)
                          : AppColors.primaryBlue.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      isEnrolled ? "Enrolled" : "Enroll",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                // Star rating
                Positioned(
                  bottom: 7,
                  left: 7,
                  child: courseStarRating(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget courseStarRating() {
    double rating = double.tryParse(courseRating) ?? 0.0;
    final fullStarCount = rating.floor();
    final decimalPart = rating - fullStarCount;
    final halfStarCount = decimalPart >= 0.5 ? 1 : 0;
    final emptyStarCount = 5 - fullStarCount - halfStarCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(fullStarCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.5),
              child: Icon(Icons.star, size: 16, color: AppColors.ratingYellow),
            );
          }),
          ...List.generate(halfStarCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.5),
              child: Icon(Icons.star_half,
                  size: 16, color: AppColors.ratingYellow),
            );
          }),
          ...List.generate(emptyStarCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 1.5),
              child: Icon(Icons.star_outline,
                  size: 16, color: AppColors.ratingYellow),
            );
          }),
          SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}

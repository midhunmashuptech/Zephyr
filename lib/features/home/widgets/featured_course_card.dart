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
  final bool isEnrolled;
  const FeaturedCourseCard({
    super.key,
    required this.course,
    required this.index,
    required this.isEnrolled,
  });

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
      child: SizedBox(
                    width: 280,
        child: Card(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.30),
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
                      height: 150,
                      width: 280,
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
                  Positioned(bottom: 10, right: 20, child: courseStarRating()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text("Course Title Course",
                                    style:
                                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              ),
                            ],
                          ),
                          Text(
                                '₹${course.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    isEnrolled
                        ? Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shadowColor: Colors.deepPurpleAccent.withOpacity(0.25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EnrolledCourseDetailScreen(
                                        courseId: course.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Start Learning",
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        )
                        : Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryGreen.withOpacity(0.12),
                                    foregroundColor: AppColors.primaryGreen,
                                    side: BorderSide(
                                        color: AppColors.primaryGreen, width: 1.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CourseDetailsScreen(
                                                  courseId: course.id.toString(),
                                                )));
                                  },
                                  child: Text("Explore",
                                      style: TextStyle(fontWeight: FontWeight.w600)),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryBlue.withOpacity(0.9),
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    shadowColor:
                                        AppColors.primaryBlue.withOpacity(0.25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CourseDetailsScreen(
                                                  courseId: course.id.toString(),
                                                )));
                                  },
                                  child: Text("Subscribe",
                                      style: TextStyle(fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
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

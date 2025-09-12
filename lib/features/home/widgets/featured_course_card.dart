import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';
import 'package:zephyr/features/home/model/featured_course_model.dart';

class FeaturedCourseCard extends StatelessWidget {
  final int index;
  final Courses course;
  const FeaturedCourseCard({super.key, required this.course, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseDetailsScreen()));
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
                    height: 120,
                    child: CachedNetworkImage(
                      imageUrl: course.thumbnail ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
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
                  Positioned(
                      bottom: 10, right: 20, child: courseStarRating()),
                ],
              ),
              
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title ?? "Course Title",
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
    double rating = double.parse("3.2");
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

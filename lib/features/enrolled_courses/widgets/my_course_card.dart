import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_model.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_detail_screen.dart';

class MyCourseCard extends StatelessWidget {
  final int index;
  final Subscriptions course;
  const MyCourseCard({super.key, required this.index, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnrolledCourseDetailScreen(courseId: course.courseId.toString())));
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
                  CachedNetworkImage(height: 200, imageUrl: course.courseThumbnail ?? "",fit: BoxFit.cover,
                   placeholder: (_, __) => Shimmer.fromColors(
                                      baseColor: AppColors.grey,
                                      highlightColor: AppColors.lightGrey,
                                      child: Container(
                                        height: 200,
                                        color: AppColors.white),
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
                  Positioned(bottom: 10, right: 20, child: courseStarRating())
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          AppColors.primaryBlue.withAlpha(30),
                                      child: Iconify(
                                        Fa.graduation_cap,
                                        size: 18,
                                        color: AppColors.primaryBlue,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      // Ensure text gets the max available space
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course.courseTitle ?? "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "by John sk",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EnrolledCourseDetailScreen(courseId: course.courseId.toString())));
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                iconSize: 24,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Iconify(Bxs.videos, size: 16),
                                  SizedBox(width: 5),
                                  Text("10 Videos")
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: LinearProgressIndicator(
                                      value: 0.22,
                                      minHeight: 10,
                                      color: AppColors.primaryGreen,
                                      backgroundColor: AppColors.grey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text("22%")
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
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
    double rating = double.parse("4.4");
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
        Text("4.4",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppColors.white))
      ],
    );
  }
}

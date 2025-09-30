import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/ion.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zephyr/constants/app_constants.dart';
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
                builder: (context) => EnrolledCourseDetailScreen(
                    courseId: course.courseId.toString())));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFDEE3EA),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB0B8C1).withOpacity(0.13),
              blurRadius: 18,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: const Color(0xFFDEE3EA).withOpacity(0.08),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.width * 0.5,
                width: double.infinity,
                imageUrl: course.courseThumbnail ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                fit: BoxFit.cover,
                placeholder: (_, __) => Shimmer.fromColors(
                  baseColor: const Color(0xFFE3E6ED),
                  highlightColor: const Color(0xFFF8F9FB),
                  child: Container(height: 320, color: const Color(0xFFF8F9FB)),
                ),
              ),
            ),
            Positioned(top: 10, left: 10, child: courseStarRating()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color.fromARGB(255, 0, 0, 0),
                      Colors.transparent,
                    ],
                  ),
                ),)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color.fromARGB(255, 0, 0, 0),
                      const Color.fromARGB(0, 0, 0, 0),
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              const Color(0xFF2D3A4A).withAlpha(100),
                          child: Iconify(
                            Fa.graduation_cap,
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            course.courseTitle ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EnrolledCourseDetailScreen(
                                            courseId:
                                                course.courseId.toString())));
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFDEE3EA)),
                          iconSize: 18,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Iconify(Ic.videocam, size: 17, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  "${course.videoCount}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFDEE3EA),
                                    shadows: [
                                      Shadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Iconify(Ion.document_text, size: 17, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  "${course.pdfCount}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFDEE3EA),
                                    shadows: [
                                      Shadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Iconify(Healthicons.i_exam_multiple_choice, size: 17, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  "${course.practiceTestCount}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFDEE3EA),
                                    shadows: [
                                      Shadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: LinearProgressIndicator(
                                value: (course.progress ?? 0) / 100,
                                minHeight: 9,
                                color: const Color(0xFF3CB371),
                                backgroundColor: const Color(0xFFE3E6ED),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${(course.progress ?? 0)}%",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget courseStarRating() {
    double rating = course.ratings ?? 0.0;
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
        children: [
          ...List.generate(fullStarCount, (index) {
            return Icon(Icons.star, size: 18, color: AppColors.ratingYellow);
          }),
          ...List.generate(halfStarCount, (index) {
            return Icon(Icons.star_half,
                size: 18, color: AppColors.ratingYellow);
          }),
          ...List.generate(emptyStarCount, (index) {
            return Icon(Icons.star_outline,
                size: 18, color: AppColors.ratingYellow);
          }),
          SizedBox(width: 5),
          Text("$rating",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.white))
        ],
      ),
    );
  }
}

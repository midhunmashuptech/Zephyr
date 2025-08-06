import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';

class HomeCourseCard extends StatelessWidget {
  final int index;
  final Course course;
  const HomeCourseCard({super.key, required this.course, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseDetailsScreen()));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5 - 20,
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
                    Image.asset(course.image ?? "", fit: BoxFit.cover),
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
                      bottom: 10,
                      right: 20,
                      child: courseStarRating()
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.name ?? "",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                      SizedBox(
                        height: 40,
                        child: Text(course.description ?? "",
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Iconify(Bxs.videos, size: 20),
                            SizedBox(width: 5),
                            Text("${course.videoCount} Videos",
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget courseStarRating() {
    double rating = double.parse(course.rating ?? "0.0");
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
          return Icon(Icons.star_outline, size: 18, color: AppColors.ratingYellow);
        }),
        SizedBox(width: 5),
        Text(course.rating ?? "",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppColors.white))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/coursedetails/screens/course_details_screen.dart';

class EnrolledCourseCard extends StatelessWidget {
  final int index;
  final Course course;
  const EnrolledCourseCard(
      {super.key, required this.index, required this.course});

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
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 18, color: AppColors.ratingYellow),
                        Icon(Icons.star, size: 18, color: AppColors.ratingYellow),
                        Icon(Icons.star, size: 18, color: AppColors.ratingYellow),
                        Icon(Icons.star, size: 18, color: AppColors.ratingYellow),
                        Icon(Icons.star, size: 18, color: AppColors.ratingYellow),
                        SizedBox(width: 5),
                        Text(course.rating ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.white))
                      ],
                    ),
                  )
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
                          width: MediaQuery.of(context)
                              .size
                              .width, // Adjust padding as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.name ?? "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "by ${course.instructor}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios_rounded))
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
                                  Text("${course.videoCount} Videos")
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
}

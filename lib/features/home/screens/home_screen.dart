import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/mi.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/home/widgets/category_widget.dart';
import 'package:zephyr/features/home/widgets/home_course_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = [
    "All",
    "NEET",
    "JEE",
    "UPSC",
    "PSC",
    "SSC",
  ];

  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    courses = Course.getSampleCourses();
  }

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LayoutGradient(gradient: AppColors.greenGradient),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Section with Profile and Menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Iconify(Mi.menu)),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withAlpha(
                                        50), // changed this - withOpacity(0.2)
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    foregroundImage: AssetImage(
                                        "assets/images/kim_shin.webp"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hello, Welcome",
                                    style: TextStyle(fontSize: 13)),
                                Text(
                                  "Kim Shin",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Iconify(Mdi.bell_notification, size: 30))
                      ],
                    ),

                    SizedBox(height: 20),

                    CustomSearchBar(color: AppColors.primaryBlue),

                    SizedBox(height: 20),

                    /// Course Categories
                    Text(
                      "Courses",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),

                    Center(
                      child: Wrap(
                        children: categories
                            .map((category) => CategoryWidget(
                                categoryName:
                                    category)) // Assuming CategoryWidget fits dynamically
                            .toList(),
                      ),
                    ),

                    SizedBox(height: 20),

                    /// Recommended Section
                    Text(
                      "Recommended for you",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Wrap(
                        children: courses.asMap().entries.map((entry) {
                          int index = entry.key; // Get the index
                          Course course = entry.value; // Get the course
                          return HomeCourseCard(course: course, index: index);
                        }).toList(),
                      ),
                    ),

                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
                    //   itemCount: courses.length,
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2, // 2 cards per row
                    //     crossAxisSpacing: 10,
                    //     mainAxisSpacing: 10, // Adjust height vs width ratio
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     return HomeCourseCard(course: courses[index]);
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

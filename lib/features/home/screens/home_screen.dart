import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/mi.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/drawer/screens/drawer.dart';
import 'package:zephyr/features/drawer/screens/profile_screen.dart';
import 'package:zephyr/features/home/widgets/category_widget.dart';
import 'package:zephyr/features/home/widgets/home_course_card.dart';
import 'package:zephyr/features/notification/screens/notifications.dart';
import 'package:zephyr/features/test/screens/make_your_test_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> categories = [
    "All",
    "NEET",
    "JEE",
    "UPSC",
    "PSC",
    "SSC",
  ];

  List<Course> courses = [];
  List<Course> filteredCourses = [];
  String? searchValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  void loadCourses() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      courses = Course.getSampleCourses();
      filteredCourses = courses;
      isLoading = false;
    });
  }

  void filterCourses() {
    filteredCourses = courses
        .where((course) => (course.name ?? "")
            .toLowerCase()
            .contains((searchValue ?? "").toLowerCase()))
        .toList();
  }

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            LayoutGradient(gradient: AppColors.greenGradient),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
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
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                  icon: Iconify(
                                    Mi.menu,
                                    color: AppColors.primaryBlue,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen()));
                                },
                                child: Row(
                                  children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Hello, Welcome",
                                            style: TextStyle(fontSize: 13)),
                                        Text(
                                          "John Wick",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Notifications()));
                              },
                              icon: Iconify(Mdi.bell_notification, size: 30))
                        ],
                      ),

                      SizedBox(height: 20),

                      CustomSearchBar(
                        color: AppColors.primaryBlue,
                        onChanged: (value) {
                          setState(() {
                            searchValue = value;
                            filterCourses();
                          });
                        },
                      ),

                      SizedBox(height: 20),

                      /// Course Categories
                      (searchValue == "" || searchValue == null)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Courses",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
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
                              ],
                            )
                          : SizedBox(height: 0),

                      /// Recommended Section
                      Text(
                        "Recommended for you",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      isLoading
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: CircularProgressIndicator()),
                                ],
                              ))
                          : filteredCourses.isEmpty
                          ? Center(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: Column(
                              children: [
                                Text("No Matching Courses found!"),
                              ],
                            ),
                          ))
                          : Wrap(
                              children:
                                  filteredCourses.asMap().entries.map((entry) {
                                int index = entry.key;
                                Course course = entry.value;
                                return HomeCourseCard(
                                    course: course, index: index);
                              }).toList(),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryGreen,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MakeYourTestScreen())),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedStudyLamp,
            color: AppColors.white,
          )),
    );
  }
}

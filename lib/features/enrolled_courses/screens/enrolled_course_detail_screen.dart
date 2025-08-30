import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_course_chapter.dart';
import 'package:zephyr/features/enrolled_courses/screens/enrolled_courses_review.dart';

class EnrolledCourseDetailScreen extends StatefulWidget {
  const EnrolledCourseDetailScreen({super.key});

  @override
  State<EnrolledCourseDetailScreen> createState() =>
      _EnrolledCourseDetailScreenState();
}

class _EnrolledCourseDetailScreenState extends State<EnrolledCourseDetailScreen>
    with SingleTickerProviderStateMixin {
  EnrolledCourseProvider enrolledCourseProvider = EnrolledCourseProvider();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadCourses();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> loadCourses() async {
    final loadCourseProvider = context.read<EnrolledCourseProvider>();
    loadCourseProvider.getCourseDetails(context, "1");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    enrolledCourseProvider = context.watch<EnrolledCourseProvider>();

    return Scaffold(
      body: enrolledCourseProvider.isCourseDetailsLoading
      ? Center(child: CircularProgressIndicator())
      : Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(enrolledCourseProvider
                                  .selectedCourseDetails.thumbnail ??
                              "Image"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 260),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(enrolledCourseProvider.selectedCourseDetails.title ?? "Title",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Iconify(Ic.videocam,
                                    color: AppColors.primaryGreen),
                                const SizedBox(width: 5),
                                const Text("38 classes"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.people,
                                    color: AppColors.primaryBlue),
                                const SizedBox(width: 5),
                                const Text("50.6k"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: AppColors.primaryOrange),
                                const SizedBox(width: 5),
                                const Text("4.8"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primaryBlue,
                    indicatorColor: AppColors.primaryOrange,
                    dividerColor: AppColors.white,
                    tabs: const [
                      Tab(text: 'Chapters'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    EnrolledCourseChapter(),
                    EnrolledCoursesReview()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

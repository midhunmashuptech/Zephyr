import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/screens/assignments_screen.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';
import 'package:zephyr/features/enrolled_courses/widgets/course_action_card.dart';
import 'package:zephyr/features/enrolled_courses/widgets/my_course_card.dart';
import 'package:zephyr/features/test/screens/make_your_test_screen.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  EnrolledCourseProvider enrolledCourseProvider = EnrolledCourseProvider();

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    final loadCourseProvider = context.read<EnrolledCourseProvider>();
    loadCourseProvider.fetchEnrolledCourse(context);
  }

  @override
  Widget build(BuildContext context) {
    enrolledCourseProvider = context.watch<EnrolledCourseProvider>();
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Course Actions',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Expanded(
                        child: CourseActionCard(
                      title: 'Assignments',
                      bgcolor: AppColors.orangeCourseActionGradient,
                      icon: HugeIcons.strokeRoundedAssignments,
                      iconColor: AppColors.primaryOrange,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => AssignmentsScreen()));
                      },
                    )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: CourseActionCard(
                      title: 'Create Your Own Test',
                      bgcolor: AppColors.greenCourseActionGradient,
                      icon: HugeIcons.strokeRoundedTestTube01,
                      iconColor: AppColors.primaryGreen,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => MakeYourTestScreen()));
                      },
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Iconify(
                    Fa.graduation_cap,
                    size: 18,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Subscribed Courses',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomSearchBar(
                color: AppColors.primaryOrange,
                onChanged: (value) {
                  enrolledCourseProvider.filterCourses(value);
                },
              ),
              SizedBox(
                height: 10,
              ),
              enrolledCourseProvider.isCourseLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Lottie.asset("assets/lottie/loading.json",
                            height: 100),
                      ))
                  : enrolledCourseProvider.filteredCourses.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Lottie.asset("assets/lottie/nodata.json",
                                  height: 200),
                              SizedBox(
                                height: 10,
                              ),
                              Text("No Subscribed Course Found")
                            ],
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              enrolledCourseProvider.filteredCourses.length,
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return MyCourseCard(
                                index: index,
                                course: enrolledCourseProvider
                                    .filteredCourses[index]);
                          },
                        ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/assignments/screens/assignment_upload_screen.dart';
import 'package:zephyr/features/assignments/screens/assignments_screen.dart';
import 'package:zephyr/features/enrolled_courses/widgets/course_action_card.dart';
import 'package:zephyr/features/enrolled_courses/widgets/my_course_card.dart';
import 'package:zephyr/features/test/screens/make_your_test_screen.dart';
import 'package:zephyr/features/test/screens/test_instructions_screen.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  List<Course> courses = [];
  List<Course> filteredCourses = [];
  String? searchValue;

  @override
  void initState() {
    super.initState();
    courses = Course.getSampleCourses();
    filteredCourses = courses;
  }

  filteredCourse() {
    filteredCourses = courses
        .where((course) => (course.name ?? "")
            .toLowerCase()
            .contains((searchValue ?? "").toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
              Row(
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
                    title: 'Make a Test',
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
                  setState(() {
                    searchValue = value;
                    filteredCourse();
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              filteredCourses.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Lottie.asset("assets/lottie/nodata.json",
                              height: 200),
                          SizedBox(
                            height: 10,
                          ),
                          Text("No Data Found")
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        return MyCourseCard(
                            index: index, course: filteredCourses[index]);
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

import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:zephyr/common/widgets/custom_search_bar.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/constants/widgets/layout_gradient.dart';
import 'package:zephyr/data_class/course.dart';
import 'package:zephyr/features/enrolled_courses/widgets/enrolled_course_card.dart';
import 'package:zephyr/features/enrolled_courses/widgets/my_course_card.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen>{
  TextEditingController searchController = TextEditingController();
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    courses = Course.getSampleCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          LayoutGradient(gradient: AppColors.orangeGradient),
          SingleChildScrollView(
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
                      Iconify(
                        Fa.graduation_cap,
                        size: 18,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'My Subscribed Courses',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomSearchBar(color: AppColors.primaryOrange, 
                        onChanged: (value) {
                          setState(() {
                            searchController.text = value ?? "";
                          });
                        },),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return MyCourseCard(
                          index: index, course: courses[index]);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

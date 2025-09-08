import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';

class CourseOverview extends StatefulWidget {
  const CourseOverview({super.key});

  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  CourseProvider courseProvider = CourseProvider();

  @override
  Widget build(BuildContext context) {
    courseProvider = context.watch<CourseProvider>();
    return Scaffold(
      body: courseProvider.isLoading
      ? Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //   child: Text("About the course",
                  //       style:
                  //           TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
                  // ),
                  // SizedBox(height: 10),
                  Html(
                    data: courseProvider.courseData.description ??
                        "<p>Course description</p>",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

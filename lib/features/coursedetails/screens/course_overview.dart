import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/screens/course_chapters.dart';

class CourseOverview extends StatefulWidget {
  const CourseOverview({super.key});

  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About the course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                          SizedBox(height: 20),
                  Text(
                      "The Foundation of 10 is a fundamental concept in mathematics, especially in number systems and arithmetic. It refers to the base-10 (decimal) number system, which is the most commonly used system for counting and calculations worldwide.Understanding the Foundation of 10 helps build strong mathematical skills, making it easier to learn advanced topics in mathematics and science.Overall, It provides  clear and efficient way to represent numbers, understand their size and value, and perform the operations that allow us to solve problems in everyday life.",
                      style: TextStyle(fontSize: 18)),
                     SizedBox(height: 20),
                  SwipeableButtonView(
                    buttonText: "Enroll at 599/-",
                    buttonWidget:
                        const Icon(Icons.arrow_forward, color: AppColors.primaryOrange),
                    activeColor: AppColors.primaryOrange,
                    isFinished: isFinished,
                    onWaitingProcess: () {
                      // Simulate a delay for the button action
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          isFinished = true;
                        });
                      });
                    },
                    onFinish: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseChapters()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

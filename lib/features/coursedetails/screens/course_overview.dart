import 'package:flutter/material.dart';

class CourseOverview extends StatefulWidget {
  const CourseOverview({super.key});

  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About the course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                          SizedBox(height: 20),
                  Text(
                      "The Foundation of 10 is a fundamental concept in mathematics, especially in number systems and arithmetic. It refers to the base-10 (decimal) number system, which is the most commonly used system for counting and calculations worldwide.Understanding the Foundation of 10 helps build strong mathematical skills, making it easier to learn advanced topics in mathematics and science.Overall, It provides  clear and efficient way to represent numbers, understand their size and value, and perform the operations that allow us to solve problems in everyday life. The Foundation of 10 is a fundamental concept in mathematics, especially in number systems and arithmetic. It refers to the base-10 (decimal) number system, which is the most commonly used system for counting and calculations worldwide.Understanding the Foundation of 10 helps build strong mathematical skills, making it easier to learn advanced topics in mathematics and science.Overall, It provides  clear and efficient way to represent numbers, understand their size and value, and perform the operations that allow us to solve problems in everyday life.",
                     style: TextStyle(fontSize: 18)),
                     SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

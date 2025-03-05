import 'package:flutter/material.dart';

class CourseChapters extends StatefulWidget {
  const CourseChapters({super.key});

  @override
  State<CourseChapters> createState() => _CourseChaptersState();
}

class _CourseChaptersState extends State<CourseChapters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("overview")
          ],

        ),
      ),
      
    );
  }
}
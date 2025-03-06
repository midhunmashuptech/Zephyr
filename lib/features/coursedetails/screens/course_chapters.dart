import 'package:flutter/material.dart';
import 'package:zephyr/features/coursedetails/widgets/chapter_card.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomDropdownCard(
                title: "Mathematics",
                items: ["chap 1", "chap 2", "chap 3"],
                onSelected: (value) {},
              ),
              CustomDropdownCard(
                title: "Physics",
                items: ["chap 1", "chap 2", "chap 3"],
                onSelected: (value) {},
              ),
              CustomDropdownCard(
                title: "biology",
                items: ["chap 1", "chap 2", "chap 3"],
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

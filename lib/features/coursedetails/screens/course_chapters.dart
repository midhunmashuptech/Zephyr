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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomDropdownCard(
                title: "Mathematics",
                items: ["Chapter 1", "Chapter 2", "Chapter 3"],
                onSelected: (value) {},
              ),
              CustomDropdownCard(
                title: "Physics",
                items: ["Chapter 1", "Chapter 2", "Chapter 3"],
                onSelected: (value) {},
              ),
              CustomDropdownCard(
                title: "Biology",
                items: ["Chapter 1", "Chapter 2", "Chapter 3"],
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

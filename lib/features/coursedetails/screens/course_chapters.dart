import 'package:flutter/material.dart';
import 'package:zephyr/features/coursedetails/widgets/custom_dropdown_card.dart';

class CourseChapters extends StatefulWidget {
  const CourseChapters({super.key});

  @override
  State<CourseChapters> createState() => _CourseChaptersState();
}

class _CourseChaptersState extends State<CourseChapters> {
  int? expandedSectionIndex;

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
                onTap: () {
                  setState(() {
                    expandedSectionIndex = expandedSectionIndex == 0 ? null : 0;
                  });
                },
                isExpanded: expandedSectionIndex == 0,
              ),
              CustomDropdownCard(
                title: "Physics",
                items: ["Chapter 1", "Chapter 2", "Chapter 3"],
                onSelected: (value) {},
                onTap: () {
                  setState(() {
                    expandedSectionIndex = expandedSectionIndex == 1 ? null : 1;
                  });
                },
                isExpanded: expandedSectionIndex == 1,
              ),
              CustomDropdownCard(
                title: "Biology",
                items: ["Chapter 1", "Chapter 2", "Chapter 3"],
                onSelected: (value) {},
                onTap: () {
                  setState(() {
                    expandedSectionIndex = expandedSectionIndex == 2 ? null : 2;
                  });
                },
                isExpanded: expandedSectionIndex == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

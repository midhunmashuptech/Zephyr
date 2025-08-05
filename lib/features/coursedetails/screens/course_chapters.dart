import 'package:flutter/material.dart';
import 'package:zephyr/features/chapter_details/screens/video_play_screen.dart';
import 'package:zephyr/features/coursedetails/widgets/course_chapter_card.dart';
class CourseChapters extends StatefulWidget {
  const CourseChapters({super.key});

  @override
  State<CourseChapters> createState() => _CourseChaptersState();
}

class _CourseChaptersState extends State<CourseChapters> {
  int? expandedSectionIndex;

  void _showSubscribePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Start Learning Today"),
        content: Text("Subscribe to gain unlimited access to all lessons and resources."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () {}, child: Text("Subscribe")),
        ],
      ),
    );
  }

  void _navigateToVideoPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VideoPlayScreen()),
    );
  }

  Widget _buildDropdownCard(
    String subject, 
    int index
    ) {
    return CourseChapterCard(
      title: subject,
      items: ["Chapter 1", "Chapter 2", "Chapter 3"],
      onSelected: (value) {},
      onTap: () {
        setState(() {
          expandedSectionIndex = expandedSectionIndex == index ? null : index;
        });
      },
      isExpanded: expandedSectionIndex == index,
      onFreeItemTap: _navigateToVideoPlayer,
      onLockedTap: (index) => _showSubscribePopup(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildDropdownCard("Mathematics", 0),
              _buildDropdownCard("Physics", 1),
              _buildDropdownCard("Biology", 2),
            ],
          ),
        ),
      ),
    );
  }
}

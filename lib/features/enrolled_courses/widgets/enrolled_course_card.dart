import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_details_screen.dart';

class EnrolledCourseCard extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(String) onSelected;
  final void Function() onTap;
  final bool isExpanded;

  const EnrolledCourseCard({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    required this.onTap,
    required this.isExpanded,
  });
  

  @override
  State<EnrolledCourseCard> createState() => _EnrolledCourseCardState();
}

class _EnrolledCourseCardState extends State<EnrolledCourseCard> {
   @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.dropdownblue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ExpansionTile(
          key: Key("${widget.title}_${widget.isExpanded}"),
          initiallyExpanded: widget.isExpanded,
          onExpansionChanged: (expanded) {
          if (expanded && !widget.isExpanded) {
            widget.onTap();
          } else if (!expanded && widget.isExpanded) {
            widget.onTap();
          }
        },
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide.none, // Removes the border
          ),
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide.none, // Removes the border when collapsed
          ),
          children: widget.items.map((item) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                tileColor: AppColors.white,
                title: Text(item, style: const TextStyle(fontSize: 16)),
                onTap: () {
                  widget.onSelected(item);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChapterDetailsScreen()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
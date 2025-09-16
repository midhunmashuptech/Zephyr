import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_detail_model.dart';

class EnrolledChapterCard extends StatefulWidget {
  final String title;
  final List<Chapters> items;
  final Function(Chapters) onSelected;
  final void Function() onTap;
  final bool isExpanded;
  final String subtitle;

  const EnrolledChapterCard({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    required this.onTap,
    required this.isExpanded,
    required this.subtitle,
  });

  @override
  State<EnrolledChapterCard> createState() => _EnrolledChapterCardState();
}

class _EnrolledChapterCardState extends State<EnrolledChapterCard> {
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
                title: Text(item.chapterTitle ?? "Chapter Title", style: const TextStyle(fontSize: 16)),
                subtitle: Text(widget.subtitle,style: TextStyle(color: AppColors.primaryBlue),),
                trailing: Icon(Icons.arrow_forward_ios,color: AppColors.black,size: 18,),
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
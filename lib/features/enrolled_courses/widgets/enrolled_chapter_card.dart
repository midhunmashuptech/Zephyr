import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/chapter_details_screen.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_detail_model.dart';

class EnrolledChapterCard extends StatefulWidget {
  final String title;
  final List<Chapters> items;
  final Function(Chapters) onSelected;
  final VoidCallback onTap;
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
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      shadowColor: AppColors.primaryBlue.withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ExpansionTile(
          key: Key("${widget.title}_${widget.isExpanded}"),
          initiallyExpanded: widget.isExpanded,
          onExpansionChanged: (_) => widget.onTap(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.menu_book_rounded,
                    color: AppColors.primaryBlue, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryBlue.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          trailing: Icon(
            widget.isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryBlue,
            size: 28,
          ),
          children: List.generate(widget.items.length, (index) {
            final item = widget.items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Material(
                color: AppColors.primaryBlue.withOpacity(0.07),
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    widget.onSelected(item);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterDetailsScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.bookmark_outline,
                            color: AppColors.primaryBlue, size: 22),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            item.chapterTitle ?? "Chapter Title",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 10, vertical: 4),
                        //   decoration: BoxDecoration(
                        //     color: AppColors.primaryGreen.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(6),
                        //   ),
                        //   child: const Text(
                        //     "Enrolled",
                        //     style: TextStyle(
                        //       color: AppColors.primaryGreen,
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 13,
                        //     ),
                        //   ),
                        // ),
                        Icon(Icons.arrow_forward_ios,
                            color: AppColors.primaryBlue, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

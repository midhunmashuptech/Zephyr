import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/model/course_detail_model.dart';
import 'package:zephyr/features/coursedetails/provider/course_provider.dart';
import 'package:zephyr/features/coursedetails/screens/course_chapter_content.dart';

class CourseChapterCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Chapters> items;
  final void Function(String) onSelected;
  final VoidCallback onTap;
  final bool isExpanded;

  const CourseChapterCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.onSelected,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final courseDetailProvider = context.watch<CourseProvider>();
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      shadowColor: AppColors.primaryBlue.withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ExpansionTile(
          key: Key("$title$isExpanded"),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) => onTap(),
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
                child: Iconify(
                  Mdi.book_open_page_variant,
                  color: AppColors.primaryBlue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
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
            isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryBlue,
            size: 28,
          ),
          children: List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Material(
                color: AppColors.lightBlueGradient.withAlpha(70),
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    courseDetailProvider
                        .setSelectedChapterContents(items[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CourseChapterContent()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            items[index].chapterTitle ?? "Chapter Title",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.85),
                            ),
                          ),
                        ),
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

import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:zephyr/constants/app_constants.dart';

class CourseChapterCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final void Function(String) onSelected;
  final VoidCallback onTap;
  final bool isExpanded;
  final void Function(int index)? onLockedTap;
  final void Function()? onFreeItemTap;

  const CourseChapterCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.onSelected,
    required this.onTap,
    required this.isExpanded,
    this.onLockedTap,
    this.onFreeItemTap,
  });

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
            final isFree = index == 0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Material(
                color: isFree
                    ? AppColors.primaryBlue.withOpacity(0.07)
                    : AppColors.grey.withOpacity(0.07),
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (isFree && onFreeItemTap != null) {
                      onFreeItemTap!();
                    } else if (!isFree && onLockedTap != null) {
                      onLockedTap!(index);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Iconify(
                          isFree ? Mdi.lock_open : Mdi.lock,
                          color: isFree
                              ? const Color.fromARGB(255, 27, 162, 15)
                              : AppColors.grey,
                          size: 22,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isFree
                                  ? AppColors.primaryBlue
                                  : AppColors.black.withOpacity(0.85),
                            ),
                          ),
                        ),
                        if (isFree)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 27, 162, 15)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "Free",
                              style: TextStyle(
                                color: Color.fromARGB(255, 27, 162, 15),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
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

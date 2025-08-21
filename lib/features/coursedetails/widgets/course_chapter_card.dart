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
      color: AppColors.dropdownblue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ExpansionTile(
          key: Key("$title$isExpanded"),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) {
            if (expanded && !isExpanded) {
              onTap();
            } else if (!expanded && isExpanded) {
              onTap();
            }
          },
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          // subtitle: Text(subtitle),
          shape: RoundedRectangleBorder(side: BorderSide.none),
          collapsedShape: RoundedRectangleBorder(side: BorderSide.none),
          children: List.generate(items.length, (index) {
            final isFree = index == 0;
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                tileColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                title: Text(
                  items[index],
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(subtitle,style: TextStyle(color: AppColors.primaryBlue),),
                trailing: isFree
                    ? Iconify(
                        Mdi.lock_open,
                        color: const Color.fromARGB(255, 27, 162, 15),
                      )
                    : Iconify(Mdi.lock, color: AppColors.grey),
                onTap: () {
                  if (isFree && onFreeItemTap != null) {
                    onFreeItemTap!();
                  } else if (!isFree && onLockedTap != null) {
                    onLockedTap!(index);
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selected
                ? color.withAlpha(20)
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

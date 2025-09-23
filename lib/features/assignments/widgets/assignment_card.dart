import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zephyr/constants/app_constants.dart' show AppColors;
import 'package:zephyr/features/assignments/screens/assignment_upload_screen.dart';

class AssignmentCard extends StatelessWidget {
  final String heading;
  final String date;
  final String type;
  final String assignmentId;

  const AssignmentCard({
    super.key,
    required this.heading,
    required this.date,
    required this.type,
    required this.assignmentId,
  });

  String formatDateTime(String dateTimeStr) {
    if (dateTimeStr.isEmpty) return "Date not specified";
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return DateFormat("MMM d, yyyy • hh:mm a").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentUploadScreen(
              assignmentTitle: heading,
              contentType: type,
              assignmentId: assignmentId,
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.white,
        elevation: 4,
        shadowColor: AppColors.primaryBlue.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightBlue)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.lightBlueGradient, AppColors.primaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.08),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.assignment_rounded,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: AppColors.primaryGreen,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            formatDateTime(date),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            type.toUpperCase() == "HTML"
                                ? "TEXT"
                                : type.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

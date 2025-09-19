import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/timelinedata.dart';
import 'package:zephyr/features/drawer/provider/timeline_provider.dart';
import 'package:zephyr/features/drawer/widgets/timeline_item.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  TimelineProvider timelineProvider = TimelineProvider();

  // Function to get the formatted label for Today, Tomorrow, and Yesterday
  String getDayLabel(DateTime date) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (isSameDay(date, today)) {
      return "Today, ${DateFormat('EEEE').format(date)}";
    } else if (isSameDay(date, tomorrow)) {
      return "Tomorrow, ${DateFormat('EEEE').format(date)}";
    } else if (isSameDay(date, yesterday)) {
      return "Yesterday, ${DateFormat('EEEE').format(date)}";
    } else {
      return DateFormat('EEEE').format(date);
    }
  }

  // Helper function to check if two dates are the same
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> loadTimeline(DateTime date) async {
    final loadProvider = context.read<TimelineProvider>();
    loadProvider.setSelectedDate(date);
    await loadProvider.fetchTimelineActivities(context: context);
  }

  @override
  void initState() {
    super.initState();
    loadTimeline(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    timelineProvider = context.watch<TimelineProvider>();
    String formattedDate = DateFormat('MMM d, yyyy').format(timelineProvider.currentSelectedDate);
    String formattedDay = getDayLabel(timelineProvider.currentSelectedDate);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const BackButton(),
                    const SizedBox(width: 10),
                    const Text(
                      'Timeline',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 0.95,
                          ),
                        ),
                        Text(
                          formattedDay,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            height: 0.95,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.calendar_today, color: Colors.black),
                      onPressed: () => _selectDate(context, timelineProvider.currentSelectedDate),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            // Horizontal Date Selector
            _buildDateSelector(timelineProvider.currentSelectedDate),

            const Divider(thickness: 1),

            Expanded(
              child:timelineProvider.isTimelineLoading
              ? Center(child: CircularProgressIndicator()) 
              : timelineProvider.timelineActivities.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/lottie/empty_data.json",
                              width: 200),
                          SizedBox(height: 20),
                          Text(
                            "No Activities!",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListView.builder(
                        itemCount: timelineProvider.timelineActivities.length,
                        itemBuilder: (context, index) {
                          return TimelineItem(
                            item: timelineProvider.timelineActivities[index],
                            isFirst: index == 0,
                            isLast: index ==
                                timelineProvider.timelineActivities.length,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Horizontally scrollable date picker
  Widget _buildDateSelector(DateTime selectedDate) {
    DateTime startDate = selectedDate.subtract(const Duration(days: 3));
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7, // Show 7 days (3 before, selected, and 3 after)
        itemBuilder: (context, index) {
          DateTime date = startDate.add(Duration(days: index));
          bool isSelected = isSameDay(date, selectedDate);

          return GestureDetector(
            onTap: () {
              loadTimeline(date);
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date), // Short weekday (e.g., "Mon")
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Open date picker and update UI
  Future<void> _selectDate(BuildContext context, DateTime selectedDate ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      loadTimeline(pickedDate);
    }
  }
}

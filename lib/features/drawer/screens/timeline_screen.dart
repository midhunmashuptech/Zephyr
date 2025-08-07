import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/data_class/timelinedata.dart';
import 'package:zephyr/features/drawer/widgets/timeline_item.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final Map<String, List<TimelineItemData>> timelineData = {
    DateFormat('dd-MM-yyyy').format(DateTime.now()): [
      TimelineItemData(
        title: "Learn a New Language",
        subtitle: "Video",
        time: "06:48 PM",
        color: Colors.blue,
      ),
      TimelineItemData(
        title: "The Best Teachers",
        subtitle: "Video",
        time: "02:30 PM",
        color: Colors.purple,
      ),
      TimelineItemData(
        title: "Quantum Mechanics Questions",
        subtitle: "Practice Test",
        time: "11:20 AM",
        color: Colors.green,
      ),
      TimelineItemData(
        title: "Upload your CV",
        subtitle: "Assignment",
        time: "08:55 AM",
        color: Colors.red,
      ),
    ],
    DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1))):
        [
      TimelineItemData(
        title: "Learn a New Language",
        subtitle: "Video",
        time: "06:48 PM",
        color: Colors.blue,
      ),
      TimelineItemData(
        title: "The Best Teachers",
        subtitle: "Video",
        time: "02:30 PM",
        color: Colors.purple,
      ),
      TimelineItemData(
        title: "Upload your CV",
        subtitle: "Assignment",
        time: "08:55 AM",
        color: Colors.red,
      ),
    ]
  };

  // final List<TimelineItemData> items = const [
  //   TimelineItemData(
  //     title: "Learn a New Language",
  //     subtitle: "Video",
  //     time: "06:48 PM",
  //     color: Colors.blue,
  //   ),
  //   TimelineItemData(
  //     title: "The Best Teachers",
  //     subtitle: "Video",
  //     time: "02:30 PM",
  //     color: Colors.purple,
  //   ),
  //   TimelineItemData(
  //     title: "Quantum Mechanics Questions",
  //     subtitle: "Practice Test",
  //     time: "11:20 AM",
  //     color: Colors.green,
  //   ),
  //   TimelineItemData(
  //     title: "Upload your CV",
  //     subtitle: "Assignment",
  //     time: "08:55 AM",
  //     color: Colors.red,
  //   ),
  // ];

  DateTime selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, yyyy').format(selectedDate);
    String formattedDay = getDayLabel(selectedDate);

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
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            // Horizontal Date Selector
            _buildDateSelector(),

            const Divider(thickness: 1),

            Expanded(
              child:
                  timelineData[DateFormat('dd-MM-yyyy').format(selectedDate)] ==
                          null
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lottie/empty_data.json", width: 200),
                            SizedBox(height: 20),
                            Text("No Activities!", style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: ListView.builder(
                            itemCount: (timelineData[DateFormat('dd-MM-yyyy')
                                        .format(selectedDate)] ??
                                    [])
                                .length,
                            itemBuilder: (context, index) {
                              final item = timelineData[DateFormat('dd-MM-yyyy')
                                      .format(selectedDate)] ??
                                  [];
                              return TimelineItem(
                                item: item[index],
                                isFirst: index == 0,
                                isLast: index == item.length - 1,
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
  Widget _buildDateSelector() {
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
              setState(() {
                selectedDate = date;
              });
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
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && !isSameDay(pickedDate, selectedDate)) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}

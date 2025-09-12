// import 'package:flutter/material.dart';
// import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
// import 'package:iconify_flutter_plus/icons/bxs.dart';
// import 'package:zephyr/constants/app_constants.dart';
// import 'package:zephyr/features/live_class/widgets/live_class_card.dart';

// class LiveRecordingScreen extends StatefulWidget {
//   const LiveRecordingScreen({super.key});

//   @override
//   State<LiveRecordingScreen> createState() => _LiveRecordingScreenState();
// }

// class _LiveRecordingScreenState extends State<LiveRecordingScreen> {
//   @override
//   Widget build(BuildContext context) {
//  return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                  Row(
//                   children: [ Iconify(Bxs.videos),
//                   SizedBox(width: 4),
//                   Text("245"),],
//                  ),
//                   Row(
//                     children: [
//                     Column(children: [
//                       Text("Aug 27,2025",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
//                       Text("Today,Tuesday"),
//                     ],
//                     ),
//                     IconButton(
//                     icon: Icon(Icons.calendar_month,color: AppColors.black,),
//                     onPressed: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                     //  code
//                       }
//                     },
//                     ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             LiveClassCard(
//               className: "Foundation of class 10",
//               tutorName: "Ankitha Sasikumar",
//               date: "Feb 20",
//               year: "2025",
//               duration: "10:00 AM - 11:00 AM",
//               imageUrl: "assets/images/course_bg1.jpg",
//               imageColor: AppColors.lightGreen,
//               currenttab: "Recordings",
//             ),
//             LiveClassCard(
//               className: "Foundation of class 10",
//               tutorName: "Ankitha Sasikumar",
//               date: "Feb 20",
//               year: "2025",
//               duration: "10:00 AM - 11:00 AM",
//               imageUrl: "assets/images/course_bg3.jpg",
//               imageColor: AppColors.lightGreen,
//               currenttab: "Recordings",
//             ),
//           ],
//         )
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:intl/intl.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart';

class LiveRecordingScreen extends StatefulWidget {
  const LiveRecordingScreen({super.key});

  @override
  State<LiveRecordingScreen> createState() => _LiveRecordingScreenState();
}

class _LiveRecordingScreenState extends State<LiveRecordingScreen> {
  DateTime selectedDate = DateTime.now();
  final currentDate = DateTime.now();

  // Function to get the label for Today, Tomorrow, Yesterday
  String getDayLabel(DateTime date) {
    // Check if it's today
    if (isSameDay(date, currentDate)) {
      return "Today, ${DateFormat('EEEE').format(date)}";
    }

    // Check if it's tomorrow
    if (isSameDay(date, currentDate.add(Duration(days: 1)))) {
      return "Tomorrow, ${DateFormat('EEEE').format(date)}";
    }

    // Check if it's yesterday
    if (isSameDay(date, currentDate.subtract(Duration(days: 1)))) {
      return "Yesterday, ${DateFormat('EEEE').format(date)}";
    }

    // Return the formatted day if it's not Today, Tomorrow, or Yesterday
    return DateFormat('EEEE').format(date);
  }

  // Helper function to check if two dates are on the same day
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Iconify(Bxs.videos),
                      SizedBox(width: 4),
                      Text("245"),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 0.95, // Reduces the line height
                            ),
                          ),
                          Text(
                            formattedDay,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 0.95, // Reduces the line height
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          color: AppColors.black,
                          size: 30,
                        ),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              formattedDay = getDayLabel(pickedDate);
                            });
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Opacity(
                opacity: 0.5,
                child: Divider(
                  color: AppColors.grey,
                )),
            LiveClassCard(
              className: "Foundation of class 10",
              tutorName: "Ankitha Sasikumar",
              imageUrl: "assets/images/course_bg1.jpg",
              imageColor: AppColors.lightGreen,
              currenttab: "Recordings", startDate: '', enddate: '',
            ),
            LiveClassCard(
              className: "Foundation of class 10",
              tutorName: "Ankitha Sasikumar",
              imageUrl: "assets/images/course_bg3.jpg",
              imageColor: AppColors.lightGreen,
              currenttab: "Recordings", startDate: '', enddate: '',
            ),
          ],
        ),
      ),
    );
  }
}

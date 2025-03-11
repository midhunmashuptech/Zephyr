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
//                       Text("Aug 27,2025",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
//               tutorName: "By Ankitha Sasikumar",
//               date: "Feb 20",
//               year: "2025",
//               duration: "10:00 AM - 11:00 AM",
//               imageUrl: "assets/images/course_bg1.jpg",
//               imageColor: AppColors.lightGreen, 
//               currenttab: "Recordings",
//             ),
//             LiveClassCard(
//               className: "Foundation of class 10",    
//               tutorName: "By Ankitha Sasikumar",
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

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, yyyy').format(selectedDate);
    String formattedDay = DateFormat('EEEE').format(selectedDate);

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
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(formattedDay,style:TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal)),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_month, color: AppColors.black),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null && pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            LiveClassCard(
              className: "Foundation of class 10",
              tutorName: "By Ankitha Sasikumar",
              date: "Feb 20",
              year: "2025",
              duration: "10:00 AM - 11:00 AM",
              imageUrl: "assets/images/course_bg1.jpg",
              imageColor: AppColors.lightGreen,
              currenttab: "Recordings",
            ),
            LiveClassCard(
              className: "Foundation of class 10",
              tutorName: "By Ankitha Sasikumar",
              date: "Feb 20",
              year: "2025",
              duration: "10:00 AM - 11:00 AM",
              imageUrl: "assets/images/course_bg3.jpg",
              imageColor: AppColors.lightGreen,
              currenttab: "Recordings",
            ),
          ],
        ),
      ),
    );
  }
}

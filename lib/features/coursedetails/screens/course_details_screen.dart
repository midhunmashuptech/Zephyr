import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/curved_widget.dart';
import 'package:zephyr/constants/app_constants.dart';

class CourseDetailsScreen extends StatefulWidget {
  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CurvedContainer(), // Your custom clipper
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.1 / 3,
              color: Colors.green,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text('Course Details'),
                bottom: TabBar(
                  dividerColor: AppColors.primaryOrange,
                  labelColor: AppColors.primaryBlue,
                  indicatorColor: AppColors.primaryGreen,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Chapters'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Overview Page')),
                Center(child: Text('Lessons Page')),
                Center(child: Text('Reviews Page')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:zephyr/common/widgets/curved_widget.dart';
// import 'package:zephyr/constants/app_constants.dart';

// class CourseDetailsScreen extends StatefulWidget {
//   @override
//   _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
// }

// class _CourseDetailsScreenState extends State<CourseDetailsScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ClipPath(
//             clipper: CurvedContainer(), // Your custom clipper
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 1.1 / 3,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/course_bg1.jpg'), // Replace with your asset path
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 title: Text('Course Details'),
//                 bottom: TabBar(
//                   dividerColor: AppColors.primaryOrange,
//                   labelColor: AppColors.primaryBlue,
//                   indicatorColor: AppColors.primaryGreen,
//                   controller: _tabController,
//                   tabs: const [
//                     Tab(text: 'Overview'),
//                     Tab(text: 'Chapters'),
//                     Tab(text: 'Reviews'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 Center(child: Text('Overview Page')),
//                 Center(child: Text('Lessons Page')),
//                 Center(child: Text('Reviews Page')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

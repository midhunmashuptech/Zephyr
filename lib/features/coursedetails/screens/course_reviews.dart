import 'package:flutter/material.dart';

class CourseReviews extends StatefulWidget {
  const CourseReviews({super.key});

  @override
  State<CourseReviews> createState() => _CourseReviewsState();
}

class _CourseReviewsState extends State<CourseReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("overview")
          ],

        ),
      ),
      
    );
  }
}
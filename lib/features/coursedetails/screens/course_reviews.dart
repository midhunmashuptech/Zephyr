import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/coursedetails/widgets/review_card.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 7),
                           Text("5"),
                           SizedBox(width: 7),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(10),
                              value: 0.9,
                              backgroundColor: AppColors.grey,
                              color: AppColors.primaryGreen,
                              minHeight: 7,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 7),
                          Text("4"),
                          SizedBox(width: 7),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(10),
                              value: 0.8,
                              backgroundColor: AppColors.grey,
                              color: AppColors.primaryGreen,
                              minHeight: 7,
                            ),
                          ),
                          SizedBox(width: 70),
                          Text("4.8",style: TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,),)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 7),
                          Text("3"),
                          SizedBox(width: 7),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(10),
                              value: 0.8,
                              backgroundColor: AppColors.grey,
                              color: AppColors.primaryGreen,
                              minHeight: 7,
                            ),
                          ),
                           SizedBox(width: 60),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 7),
                          Text("2"),
                          SizedBox(width: 7),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(10),
                              value: 0.4,
                              backgroundColor: AppColors.grey,
                              color: AppColors.primaryGreen,
                              minHeight: 7,
                            ),
                          ),
                          
                          SizedBox(width: 60 ),
                          Text("70 reviews",style: TextStyle(color:AppColors.rating_grey),)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 7),
                          Text("1"),
                          SizedBox(width: 7),
                          const Icon(Icons.star, color: AppColors.primaryOrange,size: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(10),
                              value: 0.1,
                              backgroundColor: AppColors.grey,
                              color: AppColors.primaryGreen,
                              minHeight: 7,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ReviewCard(userName: "Athulya Ajayakumar", userImage: "assets/images/yaami.jpg", reviewText: "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.", timeAgo: "15 min ago"),
              ReviewCard(userName: "Anaswara Venu", userImage: "assets/images/yaami.jpg", reviewText: "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.", timeAgo: "50 min ago"),
              ReviewCard(userName: "Midhun Murali", userImage: "assets/images/yaami.jpg", reviewText: "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.", timeAgo: "1hr ago"),
              ReviewCard(userName: "Dony Baby", userImage: "assets/images/yaami.jpg", reviewText: "The course is very informative and the instructor is very knowledgeable. I would recommend this course to anyone who wants to learn more about the subject.", timeAgo: "1hr 30 min ago"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      
    );
  }
}
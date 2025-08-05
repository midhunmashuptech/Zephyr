import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/rating_star_widget.dart';
import 'package:zephyr/constants/app_constants.dart';

class MyReviewCard extends StatefulWidget {
  final String userName;
  final String userImage;
  final String reviewText;
  final double rating;
  const MyReviewCard(
      {required this.userName,
      required this.userImage,
      required this.reviewText,
      required this.rating,
      super.key});

  @override
  State<MyReviewCard> createState() => _MyReviewCardState();
}

class _MyReviewCardState extends State<MyReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(widget.userImage),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  RatingStarWidget(rating: widget.rating)
                ],
              ),
            ],
          ),
          Text("3.5")
        ],
      ),
      SizedBox(height: 10,),
      Text(widget.reviewText,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.justify,),
      SizedBox(height: 10),
      Center(child: Text("Your review has been submitted successfully!",style: TextStyle(color: AppColors.primaryBlue,fontWeight: FontWeight.w500),))
    
    ]
    );
  }
}

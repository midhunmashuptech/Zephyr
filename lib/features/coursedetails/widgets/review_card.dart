import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/rating_star_widget.dart';
import 'package:zephyr/constants/app_constants.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final String reviewText;
  final String timeAgo;
  final double rating;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.reviewText,
    required this.timeAgo,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(userImage),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingStarWidget(rating: rating),
                      SizedBox(width: 7),
                      Text(
                        timeAgo,
                        style: TextStyle(color: AppColors.ratingGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            reviewText,
            style: TextStyle(color: AppColors.ratingGrey),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

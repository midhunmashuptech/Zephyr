import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final String reviewText;
  final String timeAgo;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.reviewText,
    required this.timeAgo,
  }) : super(key: key);

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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.star, color: AppColors.primaryOrange, size: 15),
                      Icon(Icons.star, color: AppColors.primaryOrange, size: 15),
                      Icon(Icons.star, color: AppColors.primaryOrange, size: 15),
                      Icon(Icons.star, color: AppColors.primaryOrange, size: 15),
                      SizedBox(width: 7),
                      Text(
                        timeAgo,
                        style: TextStyle(color: AppColors.rating_grey),
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
            style: TextStyle(color: AppColors.rating_grey),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommentsListingScreen extends StatelessWidget {
  const CommentsListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/no_comments.json", width: 250),
          Text("No comments yet!"),
        ],
      ),
    );
  }
}
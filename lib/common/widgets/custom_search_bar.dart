import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({super.key});
  
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: AppColors.white, // Light green background
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(30),
            blurRadius: 10,
            spreadRadius: 3
          )
        ]
      ),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          hintText: 'Search',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue, // Button background color
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                print("Search button pressed");
              },
            ),
          ),
        ),
      ),
    );
  }
}
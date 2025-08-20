import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class CustomSearchBar extends StatefulWidget {
  final Color color;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    super.key,
    required this.color,
    required this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(30),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search',
          border: InputBorder.none,
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Handle search button click
                },
              ),
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

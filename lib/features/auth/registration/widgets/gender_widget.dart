import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class GenderWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final int index;
  final String? selectedIndex;
  final Color color;
  const GenderWidget(
      {required this.label,
      required this.icon,
      required this.index,
      this.selectedIndex,
      required this.color,
      super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50), // soft shadow
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(0, 4), // horizontal, vertical
                ),
              ],
              borderRadius: BorderRadius.circular(15),
              color: widget.color,
              border: Border.all(color: AppColors.white, width: 3)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  color: AppColors.white,
                  size: 35,
                ),
                SizedBox(height: 5),
                Text(
                  widget.label,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ),
        if(widget.label.toLowerCase() == widget.selectedIndex)
        Positioned(
          right: -5,
          top: -5,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 2, color: AppColors.white)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.check_rounded, color: AppColors.white, size: 20,),
            ),
          )
        )
      ],
    );
  }
}

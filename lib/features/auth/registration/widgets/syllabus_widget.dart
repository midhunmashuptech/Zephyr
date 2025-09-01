import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class SyllabusWidget extends StatefulWidget {
  final String label;
  final int index;
  final int? selectedIndex;
  final Color color;
  const SyllabusWidget(
      {required this.label,
      required this.index,
      this.selectedIndex,
      required this.color,super.key});

  @override
  State<SyllabusWidget> createState() => _SyllabusWidgetState();
}

class _SyllabusWidgetState extends State<SyllabusWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: (widget.index + 1) == widget.selectedIndex ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.8,
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
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: (widget.index + 1) == widget.selectedIndex ? 34 : 30),
              ),
            ),
          ),
        ),
        if((widget.index + 1) == widget.selectedIndex)
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

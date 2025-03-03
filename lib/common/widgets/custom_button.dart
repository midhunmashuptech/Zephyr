import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final Color? textcolor;
  const CustomButton(
      {super.key, required this.text, this.onPressed, this.color, this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
            style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),)
            ),
            child: Text(text,
            style: TextStyle(color: textcolor)),
         
        ),
      ),
    );
  }
}

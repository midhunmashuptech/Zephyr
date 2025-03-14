import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Image Viewer"),
      ),
      body: Center(
        child: Image.network("https://zephyrentrance.in//assets/images/WhatsApp%20Image%202023-12-14%20at%2012.24.46%20PM.jpeg"),
      )
    );
  }
}
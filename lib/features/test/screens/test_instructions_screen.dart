import 'package:flutter/material.dart';

class TestInstructionsScreen extends StatelessWidget {
  const TestInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Center(child: Image.asset("assets/images/quiz_bg.png", width: MediaQuery.of(context).size.width * 0.7,))

          ],
        )
      ),
    );
  }
}
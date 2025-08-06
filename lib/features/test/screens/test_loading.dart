import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestLoading extends StatefulWidget {
  const TestLoading({super.key});

  @override
  State<TestLoading> createState() => _TestLoadingState();
}

class _TestLoadingState extends State<TestLoading> {
  @override
  void initState() {
    _navigate();
    super.initState();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Lottie.asset("assets/lottie/loading.json")),
            SizedBox(
              height: 9,
            ),
            Text(
              "Preparing your questions\nthis may take a few seconds.",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

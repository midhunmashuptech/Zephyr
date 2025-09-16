import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/test/provider/make_test_provider.dart';
import 'package:zephyr/features/test/screens/test_quiz_screen.dart';
import 'package:zephyr/features/test/screens/test_webview.dart';

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
    final loadProvider = context.read<MakeTestProvider>();
    loadProvider.generateQuiz(context);
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
                child: Lottie.asset("assets/lottie/test_loading.json")),
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

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
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
              SizedBox(height: 9,),
              Text("Preparing your questions\nthis may take a few seconds.",textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

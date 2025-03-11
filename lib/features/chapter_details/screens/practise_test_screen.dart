import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/data_class/practise_test.dart';
import 'package:zephyr/features/chapter_details/widgets/practise_test_card.dart';

class PractiseTestScreen extends StatefulWidget {
  const PractiseTestScreen({super.key});

  @override
  State<PractiseTestScreen> createState() => _PractiseTestScreenState();
}

class _PractiseTestScreenState extends State<PractiseTestScreen> {
  List<PractiseTest> tests = [];

  @override
  void initState() {
    super.initState();
    tests = PractiseTest.getSampleTests(); // Ensure this method exists
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Iconify(Bi.box_fill, size: 22),
            SizedBox(width: 10),
            Text("Practise Test"),
          ],
        ),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: tests.isEmpty
            ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/empty_data.json", width: 250),
                SizedBox(height: 10),
                Text("No practise tests available"),
              ],
            ))
            : SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      ListView.builder(
                        itemCount: tests.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PractiseTestCard(practiseTest: tests[index]); // Pass data
                        },
                      ),
                    ],
                  ),
                ),
            ),
      ),
    );
  }
}

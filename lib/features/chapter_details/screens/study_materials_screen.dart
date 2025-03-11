import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/data_class/study_material.dart';
import 'package:zephyr/features/chapter_details/widgets/study_material_card.dart';

class StudyMaterialsScreen extends StatefulWidget {
  const StudyMaterialsScreen({super.key});

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  List<StudyMaterial> files = [];

  @override
  void initState() {
    super.initState();
    files = StudyMaterial.getSampleFiles(); // Ensure this method exists
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Iconify(Bi.box_fill, size: 22),
            SizedBox(width: 10),
            Text("Study Materials"),
          ],
        ),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: files.isEmpty
            ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/empty_data.json", width: 250),
                SizedBox(height: 10),
                Text("No study materials available"),
              ],
            ))
            : SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      ListView.builder(
                        itemCount: files.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return StudyMaterialCard(studyMaterial: files[index]); // Pass data
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

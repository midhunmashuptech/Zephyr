import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/akar_icons.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:zephyr/features/chapter_details/widgets/study_material_card.dart';

class StudyMaterialsScreen extends StatelessWidget {
  const StudyMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Iconify(Bi.box_fill, size: 22,),
            SizedBox(width: 10),
            Text("Study Materials"),
          ],
        ),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StudyMaterialCard()
          ],
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa_solid.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';

class AssignmentUploadScreen extends StatefulWidget {
  const AssignmentUploadScreen({super.key});

  @override
  State<AssignmentUploadScreen> createState() => _AssignmentUploadScreenState();
}

class _AssignmentUploadScreenState extends State<AssignmentUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        title: Text('Assignment'),
        backgroundColor: AppColors.lightGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Write note on Photosynthesis.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              SizedBox(height: 10),
              Text(
                  'Explain the overall process of photosynthesis, including the reactants and products involved.',maxLines: 3,overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              SizedBox(height: 30),
              Text('Maximum size for a file: 25MB',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGreen)),
              SizedBox(height: 10),
              Text('Maximum no of attachements: 3',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGreen)),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.lightGrey,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Iconify(
                          FaSolid.file_pdf,
                          color: AppColors.darkred,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                      "Photosynthesis assignment.pdf",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                      color: AppColors.darkred,
                      iconSize: 28,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Add file",
                color: AppColors.primaryOrange,
                textcolor: AppColors.white,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Submit",
                color: AppColors.primaryBlue,
                textcolor: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

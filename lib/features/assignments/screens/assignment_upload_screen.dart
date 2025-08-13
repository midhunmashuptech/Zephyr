import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa_solid.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';

class AssignmentUploadScreen extends StatefulWidget {
   final String date;
  final String time;
  const AssignmentUploadScreen({
    required this.date,
    required this.time,
    super.key});

  @override
  State<AssignmentUploadScreen> createState() => _AssignmentUploadScreenState();
}

class _AssignmentUploadScreenState extends State<AssignmentUploadScreen> {
  List<PlatformFile> selectedFiles = [];

  Future<void> pickFile() async {
    if (selectedFiles.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only upload up to 3 files")),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFiles.add(result.files.first);
      });
    }
  }

  void removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
  }

  Iconify getFileIcon(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    if (["jpg", "jpeg", "png", "gif", "bmp", "webp"].contains(extension)) {
      return Iconify(FaSolid.file_image,
          color: AppColors.primaryBlue, size: 30);
    } else if (["pdf"].contains(extension)) {
      return Iconify(FaSolid.file_pdf, color: AppColors.darkred, size: 30);
    } else if (["doc", "docx"].contains(extension)) {
      return Iconify(FaSolid.file_word, color: Colors.blue, size: 30);
    } else if (["xls", "xlsx"].contains(extension)) {
      return Iconify(FaSolid.file_excel, color: Colors.green, size: 30);
    } else if (["ppt", "pptx"].contains(extension)) {
      return Iconify(FaSolid.file_powerpoint, color: Colors.orange, size: 30);
    } else {
      return Iconify(FaSolid.file, color: Colors.grey, size: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Assignment'),
        backgroundColor: AppColors.lightGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Due date : ",style: TextStyle(color: AppColors.darkred),),
                      Text(widget.date,style: TextStyle(color: AppColors.darkred),),
                    ],
                  ), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Due time : ",style: TextStyle(color: AppColors.darkred),),
                      Text(widget.time,style: TextStyle(color: AppColors.darkred),),
                    ],
                  )],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Write note on Photosynthesis.',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black)),
                  SizedBox(height: 20),
                  Text(
                    'a) Explain the overall process of photosynthesis, including the reactants and products involved. \n\nb) Describe the two main stages of photosynthesis the light dependent reactions and the Calvin cycle. \n\nc) Discuss the factors that influence the rate of photosynthesis and how they affect plant growth.',
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30),
                  Text('Maximum size for a file: 25MB',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreen)),
                  // SizedBox(height: 10),
                  Text('Maximum no of attachments: 3',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryGreen)),
                  SizedBox(height: 20),

                  // Display selected files
                  Column(
                    children: List.generate(selectedFiles.length, (index) {
                      final file = selectedFiles[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightGrey,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                getFileIcon(file.name),
                                SizedBox(width: 15),
                                Text(
                                  file.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () => removeFile(index),
                              icon: Icon(Icons.delete),
                              color: AppColors.darkred,
                              iconSize: 28,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 10),

                  // Add File Button
                  CustomButton(
                    text: "Add file",
                    color: AppColors.primaryOrange,
                    textcolor: AppColors.white,
                    onPressed: pickFile,
                  ),

                  SizedBox(height: 10),

                  // Submit Button
                  CustomButton(
                    text: "Submit",
                    color: AppColors.primaryBlue,
                    textcolor: AppColors.white,
                    onPressed: () {
                      if (selectedFiles.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please upload at least one file.")),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

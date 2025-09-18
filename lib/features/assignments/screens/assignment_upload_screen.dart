import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/fa_solid.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/assignments/provider/assignment_provider.dart';

class AssignmentUploadScreen extends StatefulWidget {
  final String assignmentId;
  final String contentType;
  const AssignmentUploadScreen(
      {required this.contentType, required this.assignmentId, super.key});

  @override
  State<AssignmentUploadScreen> createState() => _AssignmentUploadScreenState();
}

class _AssignmentUploadScreenState extends State<AssignmentUploadScreen> {
  AssignmentProvider assignmentProvider = AssignmentProvider();

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false, // Only one file
      type: FileType.custom, // Restrict to specific extensions
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'], // Images + PDF
    );

    if (result != null && result.files.first.path != null) {
      final submitAssignmentProvider = context.read<AssignmentProvider>();
      debugPrint("File Picked: ${result.files.first.path}");
      submitAssignmentProvider.setSelectedFile(result.files.first);
    }
  }

  Future<void> loadAssignmentDetails() async {
    final assignmentProvider = context.read<AssignmentProvider>();
    await assignmentProvider.fetchAssignmentDetails(
        context: context, assignmentId: widget.assignmentId);
  }

  // Convert "2025-09-17 15:11:00" → "September 17, 2025"
  String formatDate(String dateTimeString) {
    if (dateTimeString.trim().isEmpty) {
      return "Invalid Date";
    }
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat("MMMM dd, yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

// Convert "2025-09-17 15:11:00" → "03:11 PM"
  String formatTime(String dateTimeString) {
    if (dateTimeString.trim().isEmpty) {
      return "Invalid Time";
    }
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat("hh:mm a").format(parsedDate);
    } catch (e) {
      return "Invalid Time";
    }
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
  void initState() {
    super.initState();
    loadAssignmentDetails();
  }

  @override
  Widget build(BuildContext context) {
    assignmentProvider = context.watch<AssignmentProvider>();
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
      body: assignmentProvider.isAssignmentDetailsLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            Text(
                              "Due date : ",
                              style: TextStyle(color: AppColors.darkred),
                            ),
                            Text(
                              formatDate(assignmentProvider
                                      .assignmentDetails.endTime ??
                                  ""),
                              style: TextStyle(color: AppColors.darkred),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Due time : ",
                              style: TextStyle(color: AppColors.darkred),
                            ),
                            Text(
                              formatTime(assignmentProvider
                                      .assignmentDetails.endTime ??
                                  ""),
                              style: TextStyle(color: AppColors.darkred),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Assignment Content
                        //  check widget.contentType
                        if (widget.contentType == "pdf") ...[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: SfPdfViewer.network(
                              assignmentProvider.assignmentDetails.filePath ??
                                  "https://d333c2xue188ia.cloudfront.net/assignments/vhFzVyubuJjRPqKilB0vSLEXRnYtKXNnYknZs5hA.pdf",
                            ),
                          ),
                        ] else if (widget.contentType == "image") ...[
                          CachedNetworkImage(
                    imageUrl: assignmentProvider.assignmentDetails.filePath ??
                                "https://d333c2xue188ia.cloudfront.net/assignments/TSrrLVwzwSl1iHnGHYq6mymvX34siyX8OHS9WMky.jpg",
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                        ] else if (widget.contentType == "html") ...[
                          Html(
                            data: assignmentProvider
                                    .assignmentDetails.htmlContent ??
                                """
                      <div style="text-align:center; font-family: 'Montserrat', sans-serif; color:#5170ff; margin-top:50px;">
                        <h2>⚠️ Something Went Wrong</h2>
                        <p>We couldn't load the question at the moment.<br>Please try again shortly.</p>
                      </div>""",
                          ),
                        ] else ...[
                          Text(
                            "Content type not supported",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                        // Text('Write note on Photosynthesis.',
                        //     style: TextStyle(
                        //         fontSize: 24,
                        //         fontWeight: FontWeight.w500,
                        //         color: AppColors.black)),
                        // SizedBox(height: 20),
                        // Text(
                        //   'a) Explain the overall process of photosynthesis, including the reactants and products involved. \n\nb) Describe the two main stages of photosynthesis the light dependent reactions and the Calvin cycle. \n\nc) Discuss the factors that influence the rate of photosynthesis and how they affect plant growth.',
                        //   // maxLines: 3,
                        //   // overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        // ),

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

                        // Display selected file
                        assignmentProvider.selectedFile != null
                            ? Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.lightGrey,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          getFileIcon(assignmentProvider
                                                  .selectedFile?.name ??
                                              "File name"),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              assignmentProvider
                                                      .selectedFile?.name ??
                                                  "File name",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => assignmentProvider
                                          .removeSelectedFile(),
                                      icon: Icon(Icons.delete),
                                      color: AppColors.darkred,
                                      iconSize: 28,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),

                        SizedBox(height: 10),

                        // Add File Button
                        CustomButton(
                          text: "Add file",
                          color: AppColors.primaryOrange,
                          textcolor: AppColors.white,
                          onPressed: assignmentProvider.selectedFile != null
                              ? null
                              : () => pickFile(context),
                        ),

                        SizedBox(height: 10),

                        // Submit Button
                        assignmentProvider.isAssignmentSubmitting
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primaryBlue))
                            : CustomButton(
                                text: "Submit",
                                color: AppColors.primaryBlue,
                                textcolor: AppColors.white,
                                onPressed: () async {
                                  if (assignmentProvider.selectedFile == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Please upload a file.")),
                                    );
                                  } else {
                                    await assignmentProvider.submitAssignment(
                                        context: context,
                                        assignmentId: widget.assignmentId);
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

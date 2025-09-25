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
  final String assignmentTitle;
  const AssignmentUploadScreen({
    required this.contentType,
    required this.assignmentId,
    required this.assignmentTitle,
    super.key,
  });

  @override
  State<AssignmentUploadScreen> createState() => _AssignmentUploadScreenState();
}

class _AssignmentUploadScreenState extends State<AssignmentUploadScreen> {
  AssignmentProvider assignmentProvider = AssignmentProvider();

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.files.first.path != null) {
      context.read<AssignmentProvider>().setSelectedFile(result.files.first);
    }
  }

  Future<void> loadAssignmentDetails() async {
    await context.read<AssignmentProvider>().fetchAssignmentDetails(
          context: context,
          assignmentId: widget.assignmentId,
        );
  }

  String formatDate(String dateTimeString) {
    if (dateTimeString.trim().isEmpty) return "Invalid Date";
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat("MMMM dd, yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  String formatTime(String dateTimeString) {
    if (dateTimeString.trim().isEmpty) return "Invalid Time";
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
          color: AppColors.primaryBlue, size: 28);
    } else if (["pdf"].contains(extension)) {
      return Iconify(FaSolid.file_pdf, color: AppColors.darkred, size: 28);
    } else if (["doc", "docx"].contains(extension)) {
      return Iconify(FaSolid.file_word, color: Colors.blue, size: 28);
    } else if (["xls", "xlsx"].contains(extension)) {
      return Iconify(FaSolid.file_excel, color: Colors.green, size: 28);
    } else if (["ppt", "pptx"].contains(extension)) {
      return Iconify(FaSolid.file_powerpoint, color: Colors.orange, size: 28);
    } else {
      return Iconify(FaSolid.file, color: Colors.grey, size: 28);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    loadAssignmentDetails();
  });
    
  }

  @override
  Widget build(BuildContext context) {
    assignmentProvider = context.watch<AssignmentProvider>();
    final details = assignmentProvider.assignmentDetails;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.assignmentTitle.isNotEmpty
              ? widget.assignmentTitle
              : "Assignment Details",
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: assignmentProvider.isAssignmentDetailsLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Column(
                  children: [
                    // Assignment Info Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: AppColors.lightOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.upload_file,
                                          color: AppColors.primaryBlue,
                                          size: 20),
                                      SizedBox(width: 6),
                                      Text(
                                        'Max file size: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '25MB',
                                        style: TextStyle(
                                            color: AppColors.primaryGreen),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.collections,
                                          color: AppColors.primaryBlue,
                                          size: 20),
                                      SizedBox(width: 6),
                                      Text(
                                        'Max files: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '3',
                                        style: TextStyle(
                                            color: AppColors.primaryGreen),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: AppColors.darkred, size: 18),
                                    SizedBox(width: 4),
                                    Text(
                                      formatDate(details.endTime ?? ""),
                                      style: TextStyle(
                                          color: AppColors.darkred,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: AppColors.darkred, size: 18),
                                    SizedBox(width: 4),
                                    Text(
                                      formatTime(details.endTime ?? ""),
                                      style: TextStyle(
                                          color: AppColors.darkred,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _buildAssignmentContent(details),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Submission",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Selected File
                            assignmentProvider.selectedFile != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Row(
                                      children: [
                                        getFileIcon(assignmentProvider
                                                .selectedFile?.name ??
                                            ""),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            assignmentProvider
                                                    .selectedFile?.name ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: AppColors.darkred),
                                          onPressed: () => assignmentProvider
                                              .removeSelectedFile(),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "No file selected.",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                            SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    text: "Add file",
                                    color: AppColors.primaryOrange,
                                    textcolor: AppColors.white,
                                    onPressed:
                                        assignmentProvider.selectedFile != null
                                            ? null
                                            : () => pickFile(context),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child:
                                      assignmentProvider.isAssignmentSubmitting
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                  color: AppColors.primaryBlue))
                                          : CustomButton(
                                              text: "Submit",
                                              color: AppColors.primaryBlue,
                                              textcolor: AppColors.white,
                                              onPressed: () async {
                                                if (assignmentProvider
                                                        .selectedFile ==
                                                    null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            "Please upload a file.")),
                                                  );
                                                } else {
                                                  await assignmentProvider
                                                      .submitAssignment(
                                                    context: context,
                                                    assignmentId:
                                                        widget.assignmentId,
                                                  );
                                                }
                                              },
                                            ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),

                    // Assignment Content
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAssignmentContent(details) {
    switch (widget.contentType) {
      case "pdf":
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SfPdfViewer.network(
            details.filePath ??
                "https://d333c2xue188ia.cloudfront.net/assignments/vhFzVyubuJjRPqKilB0vSLEXRnYtKXNnYknZs5hA.pdf",
          ),
        );
      case "image":
        return Center(
          child: CachedNetworkImage(
            imageUrl: details.filePath ??
                "https://d333c2xue188ia.cloudfront.net/assignments/TSrrLVwzwSl1iHnGHYq6mymvX34siyX8OHS9WMky.jpg",
            fit: BoxFit.contain,
            placeholder: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (_, __, ___) =>
                Icon(Icons.broken_image, size: 60, color: Colors.grey),
          ),
        );
      case "html":
        return SingleChildScrollView(
          child: Html(
            data: details.htmlContent ??
                """
                <div style="text-align:center; font-family: 'Montserrat', sans-serif; color:#5170ff; margin-top:50px;">
                  <h2>⚠️ Something Went Wrong</h2>
                  <p>We couldn't load the question at the moment.<br>Please try again shortly.</p>
                </div>
                """,
          ),
        );
      default:
        return Center(
          child: Text(
            "Content type not supported",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        );
    }
  }
}

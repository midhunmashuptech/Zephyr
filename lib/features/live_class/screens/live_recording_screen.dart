import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/live_class/model/recording_live_model.dart';
import 'package:zephyr/features/live_class/provider/live_provider.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card.dart';
import 'package:zephyr/features/live_class/widgets/live_class_card_with_thumbnail.dart';

class LiveRecordingScreen extends StatefulWidget {
  const LiveRecordingScreen({super.key});

  @override
  State<LiveRecordingScreen> createState() => _LiveRecordingScreenState();
}

class _LiveRecordingScreenState extends State<LiveRecordingScreen> {
  LiveProvider liveProvider = LiveProvider();

  @override
  void initState() {
    super.initState();
 WidgetsBinding.instance.addPostFrameCallback((_) {
    loadRecordings(DateTime.now());
  });
    
  }

  Future<void> loadRecordings(DateTime date) async {
    final loadProvider = context.read<LiveProvider>();
    loadProvider.setRecordingDate(date);
    await loadProvider.fetchRecordingLive(context: context);
  }

  // Function to get the label for Today, Tomorrow, Yesterday
  String getDayLabel(DateTime date) {
    final dateprovider = context.watch<LiveProvider>();
    // Check if it's today
    if (isSameDay(date, dateprovider.recordingSelectedDate)) {
      return "Today, ${DateFormat('EEEE').format(date)}";
    }

    // Check if it's tomorrow
    if (isSameDay(
        date, dateprovider.recordingSelectedDate.add(Duration(days: 1)))) {
      return "Tomorrow, ${DateFormat('EEEE').format(date)}";
    }

    // Check if it's yesterday
    if (isSameDay(
        date, dateprovider.recordingSelectedDate.subtract(Duration(days: 1)))) {
      return "Yesterday, ${DateFormat('EEEE').format(date)}";
    }

    // Return the formatted day if it's not Today, Tomorrow, or Yesterday
    return DateFormat('EEEE').format(date);
  }

  // Helper function to check if two dates are on the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    liveProvider = context.watch<LiveProvider>();
    String formattedDate =
        DateFormat('MMM d, yyyy').format(liveProvider.recordingSelectedDate);
    String formattedDay = getDayLabel(liveProvider.recordingSelectedDate);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Iconify(Bxs.videos),
                    SizedBox(width: 4),
                    Text(liveProvider.recordingLive.length.toString()),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 0.95,
                          ),
                        ),
                        Text(
                          formattedDay,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            height: 0.95,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: liveProvider.recordingSelectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null &&
                            pickedDate != liveProvider.recordingSelectedDate) {
                          loadRecordings(pickedDate);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Opacity(
              opacity: 0.5,
              child: Divider(
                color: AppColors.grey,
              )),
          liveProvider.isRecordingLoading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : liveProvider.recordingLive.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lottie/nodata.json",
                                height: 200),
                            Text("No Recordings found!"),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: liveProvider.recordingLive.length,
                        itemBuilder: (context, index) => liveProvider.recordingLive[index].isFeatured == 1
                            ? LiveClassCardWithThumbnail(
                                className: liveProvider.recordingLive[index].title ??
                                    "Class Name",
                                tutorName:
                                    (liveProvider.recordingLive[index].faculty ??
                                                Faculty(name: "Tutor name"))
                                            .name ??
                                        "",
                                startDate: liveProvider.recordingLive[index].start ??
                                    "",
                                enddate:
                                    liveProvider.recordingLive[index].end ?? "",
                                imageUrl: liveProvider.recordingLive[index].thumbnail ??
                                    "",
                                currenttab: "Recordings")
                            : LiveClassCard(
                                className: liveProvider.recordingLive[index].title ?? "Class Name",
                                tutorName: (liveProvider.recordingLive[index].faculty ?? Faculty(name: "Tutor name")).name ?? "",
                                startDate: liveProvider.recordingLive[index].start ?? "",
                                enddate: liveProvider.recordingLive[index].end ?? "",
                                imageUrl: liveProvider.recordingLive[index].thumbnail ?? "https://blog.kapdec.com/hubfs/Imported_Blog_Media/3784896.jpg",
                                currenttab: "Recordings"),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}

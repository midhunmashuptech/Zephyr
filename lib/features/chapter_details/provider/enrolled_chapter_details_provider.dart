import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_materials_model.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_video_model.dart';
import 'package:zephyr/features/chapter_details/service/enrolled_chapter_details_service.dart';
import 'package:zephyr/features/enrolled_courses/model/enrolled_course_detail_model.dart';

class EnrolledChapterDetailsProvider extends ChangeNotifier {
  Chapters _selectedChapter = Chapters();
  Chapters get selectedChapter => _selectedChapter;

  Subjects _selectedSubject = Subjects();
  Subjects get selectedSubject => _selectedSubject;

  bool _isVideosLoading = false;
  bool get isVideosLoading => _isVideosLoading;

  bool _isMaterialLoading = false;
  bool get isMaterialLoading => _isMaterialLoading;

  List<Materials> _enrolledChapterMaterials = [];
  List<Materials> get enrolledChapterMaterials => _enrolledChapterMaterials;

  List<Videos> _chapterVideos = [];
  List<Videos> get chapterVideos => _chapterVideos;

  Videos _currentlyPlayingVideo = Videos();
  Videos get currentlyPlayingVideo => _currentlyPlayingVideo;

  void setCurrentVideo(int index) {
    _currentlyPlayingVideo = chapterVideos[index];
    notifyListeners();
  }

  void setSelectedCourse(
      {required Chapters chapter, required Subjects subject}) {
    _selectedChapter = chapter;
    _selectedSubject = subject;
    notifyListeners();
  }

  void changePlayingVideo(int index) {
    _currentlyPlayingVideo = chapterVideos[index];
    notifyListeners();
  }

  void clearPlayingVideo(int index) {
    _currentlyPlayingVideo = Videos();
    notifyListeners();
  }

  Future<void> getChapterVideos(
      {required BuildContext context,
      required String enrollmentId,
      required String courseSubjectId,
      required String courseChapterId}) async {
    _isVideosLoading = true;
    notifyListeners();

    final response = await EnrolledChapterDetailsService()
        .getEnrolledChapterVideos(context,
            enrollmentId: enrollmentId,
            courseSubjectId: courseSubjectId,
            courseChapterId: courseChapterId);

    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      print(response.type ?? "None");
      if (response.type == "success") {
        _chapterVideos = response.videos ?? [];
      } else {
        _chapterVideos = [];
      }
      notifyListeners();

      _isVideosLoading = false;
      notifyListeners();
    }
  }

  //Enrolled Chapter Materials
  Future<void> fetchEnrolledChapterMaterials({
    required String enrollmentId,
    required String courseSubjectId,
    required String courseChapterId,
  }) async {
    _isMaterialLoading = true;
    notifyListeners();
    final response = await EnrolledChapterDetailsService()
        .getEnrolledChapterMaterials(
            enrollmentId: enrollmentId,
            courseSubjectId: courseSubjectId,
            courseChapterId: courseChapterId);
    if (response == null) {
      _isMaterialLoading = false;
      notifyListeners();
      showSnackBar("Failed", "Failed fetching enrolled chapter materials");
    } else {
      if (response.type == "success") {
        _enrolledChapterMaterials = response.materials ?? [];
        notifyListeners();
        showSnackBar(
            "Success", "successfully fetched enrolled chapter materials");
        _isMaterialLoading = false;
        notifyListeners();
      }
    }
  }
}

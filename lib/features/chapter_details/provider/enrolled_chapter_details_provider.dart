import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_analysis_model.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_materials_model.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_test_model.dart';
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

  bool _isTestsLoading = false;
  bool get isTestsLoading => _isTestsLoading;

  bool _isAnalysisLoading = false;
  bool get isAnalysisLoading => _isAnalysisLoading;

  List<Tests> _enrolledChapterTests = [];
  List<Tests> get enrolledChapterTests => _enrolledChapterTests;

  List<Materials> _enrolledChapterMaterials = [];
  List<Materials> get enrolledChapterMaterials => _enrolledChapterMaterials;

  Analysis _enrolledChapterAnalysis = Analysis();
  Analysis get enrolledChapterAnalysis => _enrolledChapterAnalysis;

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

//Enrolled Chapter Videos
  Future<void> getChapterVideos(
      {required BuildContext context,
      required String enrollmentId,
      required String courseSubjectId,
      required String courseChapterId}) async {
    _isVideosLoading = true;
    _chapterVideos = [];
    notifyListeners();

    final response = await EnrolledChapterDetailsService()
        .getEnrolledChapterVideos(context,
            enrollmentId: enrollmentId,
            courseSubjectId: courseSubjectId,
            courseChapterId: courseChapterId);

    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success") {
        _chapterVideos = response.videos ?? [];
        _isVideosLoading = false;
        notifyListeners();
      } else {
        _chapterVideos = [];
        _isVideosLoading = false;
        notifyListeners();
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      _isVideosLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
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
      showSnackBar("Failed", "Error loading enrolled chapter materials");
    } else {
      if (response.type == "success") {
        _enrolledChapterMaterials = response.materials ?? [];
        notifyListeners();
        _isMaterialLoading = false;
        notifyListeners();
      }
    }
  }

  //Enrolled Chapter Tests
  Future<void> fetchEnrolledChapterTest(
      {required BuildContext context,
      required String enrollmentId,
      required String courseSubjectId,
      required String courseChapterId}) async {
    _isTestsLoading = true;
    notifyListeners();
    final response = await EnrolledChapterDetailsService()
        .getEnrolledChapterTest(
            context: context,
            enrollmentId: enrollmentId,
            courseSubjectId: courseSubjectId,
            courseChapterId: courseChapterId);
    if (response == null) {
      showSnackBar("Error", "Failed to load Enrolled Chapter Tests");
      _isTestsLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _enrolledChapterTests = response.tests ?? [];
        notifyListeners();
        _isTestsLoading = false;
        notifyListeners();
      }
    }
  }

  //Enrolled Chapter Tests
  Future<void> fetchEnrolledChapterAnalysis(
      {required BuildContext context,
      required String enrollmentId,
      required String courseSubjectId,
      required String courseChapterId}) async {
    _isAnalysisLoading = true;
    notifyListeners();

    final response = await EnrolledChapterDetailsService()
        .getEnrolledChapterAnalysis(
            context: context,
            enrollmentId: enrollmentId,
            courseSubjectId: courseSubjectId,
            courseChapterId: courseChapterId);
    if (response == null) {
      showSnackBar("Error", "Failed to Fetch Enrolled Chapter Analysis");
      _isAnalysisLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _enrolledChapterAnalysis = response.analysis ?? Analysis();
        notifyListeners();
        _isAnalysisLoading = false;
        notifyListeners();
      } else {
        _isAnalysisLoading = false;
        notifyListeners();
      }
    }
  }
}

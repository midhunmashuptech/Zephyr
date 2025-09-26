//Base URL for  all API calls
const baseUrl = "https://zephyrdigital.in/api/";

// Base URL for webview
const webBaseUrl = "https://zephyrdigital.in/";

// Authentication API Endpoints
const verifyPhoneUrl = "${baseUrl}verify-phone";
const loginUrl = "${baseUrl}login";

const registerUrl = "${baseUrl}register";
const registrationDropdownOptionsUrl =
    "${baseUrl}registration-dropdown-options";
const sendRegistrationOtpUrl = "${baseUrl}send-registration-otp";
const verifyRegistrationOtpUrl = "${baseUrl}verify-registration-otp";

// Password rest API
const resetPasswordUrl = "${baseUrl}reset-user-password";
const sendresetPasswordUrl = "${baseUrl}send-reset-password-otp";
const verifyResetPasswordUrl = "${baseUrl}verify-reset-password-otp";

// Password rest API
const resetPasswordAuthUrl = "${baseUrl}reset-password";

// Home Page API
const getActiveCoursesUrl = "${baseUrl}get-active-course";
const getFeaturedCourseUrl = "${baseUrl}get-featured-courses";
const getCategoryBasedCourseUrl = "${baseUrl}get-category-based-courses";

// get User Details API's
const getUserDetailsUrl = "${baseUrl}get-user-details";
const updateUserDetailsUrl = "${baseUrl}update-user-details";
const updateProfilePictureUrl = "${baseUrl}update-profile-picture";

// enrolled courses API's
const enrolledCourseUrl = "${baseUrl}get-subscribed-courses";
const enrolledChapterUrl = "${baseUrl}get-enrollment-chapters";
const enrolledChapterVideosUrl = "${baseUrl}get-enrollment-chapter-videos";
const courseDetailUrl = "${baseUrl}get-course-details";
const courseEnrollmentsUrl = "${baseUrl}get-course-enrollments/";
const enrolledChapterMaterialsUrl =
    "${baseUrl}get-enrollment-chapter-materials";
const enrolledChapterTestUrl = "${baseUrl}get-enrollment-chapter-tests";
const enrolledCourseDetailsUrl =
    "${baseUrl}get-subscribed-course-details?course_id=";

//Live API's
const ongoingLiveUrl = "${baseUrl}get-ongoing-live-classes";
const upcomingLiveUrl = "${baseUrl}get-upcoming-live-classes";
const recordingLiveUrl = "${baseUrl}get-live-class-recordings";

//Assignment API's
const getAssignmentUrl = "${baseUrl}get-enrollment-assignments";
const getAssignmentDetailsUrl = "${baseUrl}get-assignment-details";
const getSubmittedAssignmentUrl = "${baseUrl}get-submitted-assignments";
const submitAssignmentUrl = "${baseUrl}submit-assignment";

//Test Series API's
const ongoingTestSeriesUrl = "${baseUrl}get-ongoing-test-series";
const upcomingTestSeriesUrl = "${baseUrl}get-upcoming-test-series";
const attendedTestSeriesUrl = "${baseUrl}get-attended-test-series";
const testSeriesAnalysisUrl = "${baseUrl}get-test-analysis";
const testSeriesLeaderBoardUrl = "${baseUrl}get-test-leaderboard/";

// Timeline APIs
const getTimelineActivitiesUrl = "${baseUrl}get-timeline-activity";
const postTimelineActivityUrl = "${baseUrl}post-timeline-activity";

// Make Your Test API's
const getClassSubjectOptionsUrl = "${baseUrl}get-class-and-subjects";
const getChapterOptionsUrl = "${baseUrl}get-chapters";
const getTopicOptionsUrl = "${baseUrl}get-topics";
const generateAiQuizUrl = "${baseUrl}generate-ai-practice-quiz";

// Review API's
const getCourseReviewsUrl = "${baseUrl}get-course-reviews/";
const postCourseReviewUrl = "${baseUrl}post-course-reviews";

// quiz related endpoints
const attendTest =
    "${webBaseUrl}quiz/attend-test"; // test id will be appended attend-test/{type}/{userid}/{testid}
const attendAiTest =
    "${webBaseUrl}quiz/attend-ai-quiz"; // test id will be appended attend-ai-quiz/{type}/{userid}/{testid}

const viewTestSolution = "${webBaseUrl}quiz/view-solution";

// WebView endpoint
const testUrl = "${webBaseUrl}events";
const termsAndCondition = "${webBaseUrl}contact";
const helpAndSupport = "${webBaseUrl}contact";
const aboutUs = "${webBaseUrl}about";

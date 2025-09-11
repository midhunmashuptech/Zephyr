//Base URL for  all API calls
const baseUrl = "https://zephyrdigital.in/api/";

// Authentication API Endpoints
const verifyPhoneUrl = "${baseUrl}verify-phone";
const loginUrl = "${baseUrl}login";
const registerUrl = "${baseUrl}register";
const registrationDropdownOptionsUrl =
    "${baseUrl}registration-dropdown-options";

// get User Details API's
const getUserDetailsUrl = "${baseUrl}get-user-details";
const updateUserDetailsUrl = "${baseUrl}update-user-details";
const updateProfilePictureUrl = "${baseUrl}update-profile-picture";


// enrolled courses API's
const enrolledCourseUrl = "${baseUrl}get-subscribed-courses";
const enrolledChapterUrl = "${baseUrl}get-enrollment-chapters";
const enrolledChapterVideosUrl = "${baseUrl}get-enrollment-chapter-videos";
const courseDetailUrl = "${baseUrl}get-course-details";

// Password rest API
const resetPasswordUrl = "${baseUrl}reset-user-password";

// Password rest API
const resetPasswordAuthUrl = "${baseUrl}reset-password";

// Home Page API
const getActiveCoursesUrl = "${baseUrl}get-active-course";

// Make Your Test API's
const getClassSubjectOptionsUrl = "${baseUrl}get-class-and-subjects";
const getChapterOptionsUrl = "${baseUrl}get-chapters";
const getTopicOptionsUrl = "${baseUrl}get-topics";
const generateAiQuizUrl = "${baseUrl}generate-ai-practice-quiz";

// Review API's
const getCourseReviewsUrl = "${baseUrl}get-course-reviews/";
const postCourseReviewUrl = "${baseUrl}post-course-reviews";

// Base URL for webview
const webBaseUrl = "https://zephyrentrance.in/";

// WebView endpoint
const testUrl = "${webBaseUrl}events";
const termsAndCondition = "${webBaseUrl}contact";
const helpAndSupport = "${webBaseUrl}contact";
const aboutUs = "${webBaseUrl}about";

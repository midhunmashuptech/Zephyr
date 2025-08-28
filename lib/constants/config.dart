//Base URL for  all API calls
const baseUrl = "https://zephyrdigital.in/api/";

// Authentication API Endpoints
const verifyPhoneUrl = "${baseUrl}verify-phone";
const loginUrl = "${baseUrl}login";
const registerUrl = "${baseUrl}register";
const enrolledChapterUrl ="${baseUrl}get-enrollment-chapters";

// Password rest API
const resetPasswordUrl = "${baseUrl}reset-password";

// Make Your Test API's
const getClassSubjectOptionsUrl = "${baseUrl}get-class-and-subjects";
const getChapterOptionsUrl = "${baseUrl}get-chapters";
const getTopicOptionsUrl = "${baseUrl}get-topics";
const generateAiQuizUrl = "${baseUrl}generate-ai-practice-quiz";


// Base URL for webview
const webBaseUrl = "https://zephyrentrance.in/";

// WebView endpoint
const testUrl = "${webBaseUrl}events";
const termsAndCondition = "${webBaseUrl}contact";
const helpAndSupport = "${webBaseUrl}contact";
const aboutUs = "${webBaseUrl}about";

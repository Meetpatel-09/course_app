class Config {
  final String appName = "Courses App";
  String courseAPI = "http://vpsmcq.in/API/home";
  String loginAPI = "http://vpsmcq.in/API/login";
  String registerAPI = "http://vpsmcq.in/API/user";
  String verifyAPI = "http://vpsmcq.in/API//email/verify";
  String resendOTPAPI = "http://vpsmcq.in/API/email/resendotp";
  String getMCQBankAPI = "http://vpsmcq.in/API/mcq/mcqbank/"; // after '/' send subjectid, syntax: /mbid example: /1
  String sendUserSettingsAPI = "http://vpsmcq.in/API/usermcq/setting";
  String putUserSettingsAPI = "http://vpsmcq.in/API/usermcq/setting?user_mcq_id="; // after 'user_mcq_id=' send user_mcq_id = syntax: mbid=user_mcq_id example: mbid=1
  String getUserSettingsAPI = "http://vpsmcq.in/API/usermcq/setting?mbid="; // after 'mbid=' send mbid = syntax: mbid=mbid example: mbid=1
  String getMCQQuestionBank = "http://vpsmcq.in/API/mcqbank/que/"; // after '/' send mbid, syntax: /mbid example: /1
  String sendMCQUserAnswer = "http://vpsmcq.in/API/usermcq/save";
  String getMyExams = "http://vpsmcq.in/API/myexam";
  String getMyExamsBanks = "http://vpsmcq.in/API/myexam/"; // after '/' send subjectid, syntax: /mbid example: /1
}
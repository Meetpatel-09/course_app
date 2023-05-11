
// This file consist all api links

class Config {
  final String appName = "Presento";

  static String smsAPI = "http://192.168.184.100:3838/send-sms";
  static String api = "http://192.168.184.100:5000/";

  static String userLogin = "${api}users/login";
  static String userRegister = "${api}users/signup";
  static String user = "${api}user/";

  String courseAPI = "http://vpsmcq.in/API/home";
  String loginAPI = "http://vpsmcq.in/API/login";
  String registerAPI = "http://vpsmcq.in/API/user";
  String verifyAPI = "http://vpsmcq.in/API//email/verify";
  String resendOTPAPI = "http://vpsmcq.in/API/email/resendotp";
  String getMCQBankAPI = "http://vpsmcq.in/API/mcq/mcqbank/"; // after '/' send subjectid, syntax: /subjectid example: /1
  String sendUserSettingsAPI = "http://vpsmcq.in/API/usermcq/setting";
  String putUserSettingsAPI = "http://vpsmcq.in/API/usermcq/setting?user_mcq_id="; // after 'user_mcq_id=' send user_mcq_id = syntax: mbid=user_mcq_id example: mbid=1
  String getUserSettingsAPI = "http://vpsmcq.in/API/usermcq/setting?mbid="; // after 'mbid=' send mbid = syntax: mbid=mbid example: mbid=1
  String getMCQQuestionBank = "http://vpsmcq.in/API/mcqbank/que/"; // after '/' send mbid, syntax: /mbid example: /1
  String sendMCQUserAnswer = "http://vpsmcq.in/API/usermcq/save";
  String getMyExams = "http://vpsmcq.in/API/myexam";
  String getMyExamsBanks = "http://vpsmcq.in/API/myexam/"; // after '/' send subjectid, syntax: /subjectid example: /1
  String getMyExamResult = "http://vpsmcq.in/API/result/"; // after '/' send mbid, syntax: /mbid example: /1
  String getUserProfile = "http://vpsmcq.in/API/user/profile";

  // API use to get access of media files
  String mediaAPI = "http://vpsmcq.in/API/media/"; // after '/' send file name, syntax: /fileName.extension example: /img.jpg
}
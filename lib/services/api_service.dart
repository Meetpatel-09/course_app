import 'dart:convert';

import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/user_mcq_settings/get_user_settings_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/user_answers/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/model/mcq_models/user_answers/user_mcq_answer_response_model.dart';
import 'package:course_app_ui/model/mcq_models/user_mcq_settings/user_settings_request_model.dart';
import 'package:course_app_ui/model/mcq_models/user_mcq_settings/user_settings_response_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

  // To GET the Categories and their subjects to sen on Home fragment and Exam fragment
  static Future<CourseModel> getCourses() async {

    var url = Uri.parse(Config().courseAPI);

    try {
      final response = await http.get(url);
      if(200 == response.statusCode) {

        final CourseModel courses = courseModelFromJson(response.body);

        return courses;
      } else {
        return CourseModel();
      }
    } catch(e) {
      return CourseModel();
    }
  }

  // To GET the MCQ banks as per subject selected
  static Future<MCQBanksModel> getMCQBank(String subjectID, String token) async {

    var url = Uri.parse(Config().getMCQBankAPI + subjectID);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token,
    };

    try {
      final response = await http.get(url, headers: requestHeaders);

      if(200 == response.statusCode) {

        final MCQBanksModel mcqBanks = mcqBanksModelFromJson(response.body);

        return mcqBanks;
      } else {
        return MCQBanksModel();
      }
    } catch(e) {
      return MCQBanksModel();
    }
  }

  // To POST the user settings
  static Future<UserSettingsResponseModel> userSettings(UserSettingsRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': model.token!,
    };

    var url = Uri.parse(Config().sendUserSettingsAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {

      if (response.body == '"invalid token"') {
        return UserSettingsResponseModel(status: 422, msg: "Invalid Token");
      } else {
        final UserSettingsResponseModel responseModel = userSettingsResponseModelFromJson(response.body);

        return responseModel;
      }

    } else {
      return UserSettingsResponseModel(status: response.statusCode, msg: response.reasonPhrase);
    }
  }

  // To PUT the user settings
  static Future<UserSettingsResponseModel> putUserSettings(UserSettingsRequestModel model, String userMCQPID, String token) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token,
    };

    var url = Uri.parse(Config().putUserSettingsAPI + userMCQPID);

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {

      if (response.body == '"invalid token"') {
        return UserSettingsResponseModel(status: 422, msg: "Invalid Token");
      } else {
        final UserSettingsResponseModel responseModel = userSettingsResponseModelFromJson(response.body);

        return responseModel;
      }

    } else {
      return UserSettingsResponseModel(status: response.statusCode, msg: response.reasonPhrase);
    }
  }

  // To GET the user settings
  static Future<GetUserSettingsModel> getUserSettings(String mbid, String token) async {

    var url = Uri.parse(Config().getUserSettingsAPI + mbid);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'token': token
        }
      );

      if(200 == response.statusCode) {

        final GetUserSettingsModel getUserSettingsModel = getUserSettingsModelFromJson(response.body);
        if (getUserSettingsModel.status == 200) {

          return getUserSettingsModel;
        } else {
          return GetUserSettingsModel(status: 422, message: "Error Occurred");
        }
      } else {
        return GetUserSettingsModel(status: response.statusCode, message: response.reasonPhrase);
      }
    } catch(e) {
      return GetUserSettingsModel(status: 422);
    }
  }

  // To GET the MCQ Question of a particular Question bank as per MCQ Bank id
  static Future<MCQQuestionBankModel> getMCQQuestionBank(String mbid) async {

    var url = Uri.parse(Config().getMCQQuestionBank + mbid);

    try {
      final response = await http.get(url);

      if(200 == response.statusCode) {

        final MCQQuestionBankModel mcqQuestionBank = mcqQuestionBankModelFromJson(response.body);

        return mcqQuestionBank;
      } else {
        return MCQQuestionBankModel();
      }
    } catch(e) {
      return MCQQuestionBankModel();
    }
  }

  // To POST the answers of the user
  static Future<UserMCQAnswersResponseModel> sendMCQUserAnswer(SendUserMCQAnswers model, String token, bool isFinished) async { {

    Uri url;

    if (isFinished) {
      url = Uri.parse(Config().sendMCQUserAnswer + "?finish=true");
    } else {
      url = Uri.parse(Config().sendMCQUserAnswer);
    }

    Map<String, dynamic> args = {
      "user_mcq_id": model.userMcqId,
      "mbid": model.mbid,
      "mcqid":  model.mcqid,
      "ans": model.ans,
      "que_remaining_time": model.queRemainingTime,
      "que_total_taken_time": model.queTotalTakenTime
    };

    var body = json.encode(args);

    final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-type': 'application/json',
          'token': token
        }
    );

    if (response.statusCode == 200) {
      return UserMCQAnswersResponseModel(status: response.statusCode);
    } else {
      return UserMCQAnswersResponseModel(status: response.statusCode, msg: response.reasonPhrase);
    }
  }}


}
import 'dart:convert';

import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/user_mcq_answer-response_model.dart';
import 'package:course_app_ui/model/mcq_models/user_settings_request_model.dart';
import 'package:course_app_ui/model/mcq_models/user_settings_response_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

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

  static Future<MCQBanksModel> getMCQBank(String subjectID) async {

    var url = Uri.parse(Config().getMCQBankAPI + subjectID);

    try {
      final response = await http.get(url);

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

  static Future<UserSettingsResponseModel> userSettings(UserSettingsRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': model.token,
    };

    var url = Uri.parse(Config().sendUserSettingsAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return UserSettingsResponseModel(status: response.statusCode);
    } else {
      return UserSettingsResponseModel(status: response.statusCode, msg: response.reasonPhrase);
    }
  }

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

  // static Future<UserMCQAnswersResponseModel> sendMCQUserAnswer(FormData data, String token) async {
  //
  //   print(data.fields);
  //   print("new request");
  //
  //
  //   var dio = Dio();
  //
  //   dio.options.headers= {
  //     'Accept': '*/*',
  //     'Content-Type': 'multipart/form-data',
  //     'token': token,
  //   };
  //
  //   var response = await dio.post(
  //     Config().sendMCQUserAnswer,
  //     data: data,
  //   );
  //
  //   print(response);
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> map = response.data;
  //     int status = int.parse(map.values.first.toString());
  //     if(status == 200) {
  //
  //       return UserMCQAnswersResponseModel(status: status);
  //     } else {
  //       String msg = map.values.last.toString();
  //       return UserMCQAnswersResponseModel(status: status, msg: msg);
  //     }
  //   } else {
  //     return UserMCQAnswersResponseModel(status: response.statusCode!, msg: response.statusMessage!);
  //   }
  // }

  // static Future<UserMCQAnswersResponseModel> sendMCQUserAnswer(var model, String token) async {
  //   Map<String, String> requestHeaders = {
  //     // 'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'token': token,
  //   };
  //
  //   print(model);
  //   // print(model.queTotalTakenTime);
  //   // print(model.mcqid);
  //
  //   var url = Uri.parse(Config().sendMCQUserAnswer);
  //   // List<String> mcqID =  ["22", "23", "24", "25", "26", "27", '28', "29", "30", "31"];
  //   //
  //   // Map<String,String>data = {};
  //   //
  //   // for(int i=0;i<10;i++){
  //   //   data.addAll({“mcqID[$i]”:id[i]});
  //   // }
  //   // for(int i=0;i<10;i++){
  //   //   data.addAll({“mcqID[$i]”:prices[i]});
  //   // }
  //
  //   var response = await client.post(
  //     url,
  //     headers: requestHeaders,
  //     body: json.encode(model),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return UserMCQAnswersResponseModel(status: response.statusCode);
  //   } else {
  //     return UserMCQAnswersResponseModel(status: response.statusCode, msg: response.reasonPhrase);
  //   }
  // }

  static Future<UserMCQAnswersResponseModel> sendMCQUserAnswer(var model, String token) async { {
    List<int> comments = [22, 33, 44, 43, 45, 34, 23];
    Map<String, dynamic> args = {"mcqid": comments};
    var url = Uri.parse(Config().sendMCQUserAnswer);
    var body = json.encode(args);
    final response = await http
        .post(url, body: body, headers: {'Content-type': 'application/json'});
    return UserMCQAnswersResponseModel(status: 200);
  }}
}
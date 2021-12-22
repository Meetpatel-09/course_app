import 'dart:convert';

import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/model/auth_models/login/login_response_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/otp_request_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/otp_response_model.dart';
import 'package:course_app_ui/model/auth_models/register/register_response_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static var client = http.Client();

  // static Future<LoginResponseModel> login(LoginRequestModel model) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };
  //
  //   var url = Uri.parse('Config.loginAPI');
  //
  //   var response = await client.post(
  //     url,
  //     headers: requestHeaders,
  //     body: jsonEncode(model.toJson()),
  //   );
  //
  //   return loginResponseJson(response.body);
  // }

  static Future<RegisterResponseModel> register(FormData data) async {

    var response = await Dio().post(
      Config().registerAPI,
      data: data,
    );

    // print(response.data);
    Map<String, dynamic> map = response.data;
    int status = int.parse(map.values.first.toString());
    String msg = map.values.last.toString();

    return RegisterResponseModel(status: status, msg: msg);
  }

  static Future<OTPResponseModel> otpVerify(OTPRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(Config().verifyAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return otpResponseJson(response.body);
  }

}
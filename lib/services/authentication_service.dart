import 'dart:convert';

import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/model/auth_models/login/login_response_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/otp_request_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/otp_response_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/resend_otp_request_model.dart';
import 'package:course_app_ui/model/auth_models/register/register_response_model.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static var client = http.Client();

  static Future<LoginResponseModel> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(Config().loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return loginResponseJson(response.body);
    } else {
      return LoginResponseModel(status: response.statusCode, msg: response.reasonPhrase);
    }
  }

  static Future<RegisterResponseModel> register(FormData data) async {

      var response = await Dio().post(
        Config().registerAPI,
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data;
        int status = int.parse(map.values.first.toString());
        String msg = map.values.last.toString();
        return RegisterResponseModel(status: status, msg: msg);
      } else {
        return RegisterResponseModel(status: response.statusCode!, msg: response.statusMessage!);
      }
    }

  static Future<RegisterResponseModel> googleRegister(FormData data) async {

    var response = await Dio().post(
      Config().registerAPI,
      data: data,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = response.data;
      int status = int.parse(map.values.first.toString());
      if(status == 200) {
        String u = map.values.last.toString();
        String token = "";
        int i = 0;

        for (var v in map.values) {
          i++;
          if (i == 2) {
            token = v.toString();
          }
        }
        return RegisterResponseModel(status: status, token: token, u: u);
      } else {
        String msg = map.values.last.toString();
        return RegisterResponseModel(status: status, msg: msg);
      }
    } else {
      return RegisterResponseModel(status: response.statusCode!, msg: response.statusMessage!);
    }
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

  static Future<OTPResponseModel> resendOTP(ResendOTPRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(Config().resendOTPAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return otpResponseJson(response.body);
  }

}
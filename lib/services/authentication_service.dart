import 'dart:convert';

import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/model/auth_models/login/login_response_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/otp_request_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/otp_response_model.dart';
import 'package:course_app_ui/model/auth_models/otp_verification/resend_otp_request_model.dart';
import 'package:course_app_ui/model/auth_models/profile/edit_profile_response_model.dart';
import 'package:course_app_ui/model/auth_models/profile/get_user_profile_model.dart';
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

    // 'Config.dart' file consist all the api links
    // using 'Config()' we can get the link which we want after putting '.' and the link name
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

      // Here, if the status code code is 200 then, have manually derived
      // the token, user type from response string

      // mapping the response data
      Map<String, dynamic> map = response.data;

      // getting the first element from 'map' which is response 'status' sent in response host server
      int status = int.parse(map.values.first.toString());
      if(status == 200) {

        // Storing the last element from response map in a sting variable which is the user type
        String u = map.values.last.toString();
        // declaring and initializing a string variable 'token'
        String token = "";
        // declaring and initializing an integer variable 'i'
        int i = 0;

        // in the response the second element is token so deriving it using for loop
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

  static Future<GetUserProfileModel> getUserProfile(String token) async {

    var url = Uri.parse(Config().getUserProfile);

    try {
      final response = await http.get(
          url,
          headers: {
            'Content-type': 'application/json',
            'token': token
          }
      );

      if(200 == response.statusCode) {

        final GetUserProfileModel getUserProfileModel = getUserProfileJson(response.body);
        if (getUserProfileModel.status == 200) {

          return getUserProfileModel;
        } else {
          return GetUserProfileModel(status: 422);
        }
      } else {
        return GetUserProfileModel(status: response.statusCode);
      }
    } catch(e) {
      return GetUserProfileModel(status: 422);
    }
  }

  static Future<EditProfileResponseModel> editProfile(FormData data, String token) async {

    var response = await Dio().put(
      Config().getUserProfile,
      data: data,
      options: Options(
        headers: {
        "token": token
        }
      )
    );

    if (response.statusCode == 200) {
      return EditProfileResponseModel(status: response.statusCode!);
    } else {
      return EditProfileResponseModel(status: response.statusCode!);
    }
  }

}
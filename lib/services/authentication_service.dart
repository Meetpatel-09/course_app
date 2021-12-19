import 'dart:convert';

import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/model/auth_models/login/login_response_model.dart';
import 'package:course_app_ui/model/auth_models/register/register_request_model.dart';
import 'package:course_app_ui/model/auth_models/register/register_response_model.dart';
// import 'package:course_app_ui/utils/config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static var client = http.Client();

  static Future<LoginResponseModel> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse('Config.loginAPI');

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return loginResponseJson(response.body);
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse('Config.registerAPI');

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseModel(response.body);
  }
}
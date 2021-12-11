import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    this.msg,
    this.token,
  });
  late final int status;
  late final String? msg;
  late final String? token;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'] ?? json['msg'];
    token = json['token'] ?? json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['token'] = token;
    return _data;
  }
}

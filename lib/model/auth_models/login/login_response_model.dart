import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.msg,
    this.redirect,
    this.role,
    this.token,
    this.u,
  });
  late final int status;
  late final String? msg;
  late final int? redirect;
  late final String? role;
  late final String? token;
  late final String? u;

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    redirect = json['redirect'];
    role = json['role'];
    token = json['token'];
    u = json['u'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['redirect'] = redirect;
    _data['role'] = role;
    _data['token'] = token;
    _data['u'] = u;
    return _data;
  }
}

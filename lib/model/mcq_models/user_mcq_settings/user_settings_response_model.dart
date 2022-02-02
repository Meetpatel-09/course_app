import 'dart:convert';

UserSettingsResponseModel userSettingsResponseModelFromJson(String str) => UserSettingsResponseModel.fromJson(json.decode(str));

String userSettingsResponseModelToJson(UserSettingsResponseModel data) => json.encode(data.toJson());

class UserSettingsResponseModel {
  UserSettingsResponseModel({
    required this.status,
    this.msg,
    this.userMCQID,
  });
  late final int status;
  late final String? msg;
  late final int? userMCQID;

  UserSettingsResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    userMCQID = json['user_mcq_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['user_mcq_id'] = userMCQID;
    return _data;
  }
}
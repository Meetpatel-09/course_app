import 'dart:convert';

GetUserSettingsModel getUserSettingsModelFromJson(String str) => GetUserSettingsModel.fromJson(json.decode(str));
String getUserSettingsModelToJson(GetUserSettingsModel data) => json.encode(data.toJson());

class GetUserSettingsModel {
  GetUserSettingsModel({
      this.status, 
      this.name, 
      this.message,});

  GetUserSettingsModel.fromJson(dynamic json) {
    status = json['status'];
    name = json['name'];
    message = json['message'];
  }
  int? status;
  String? name;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['name'] = name;
    map['message'] = message;
    return map;
  }

}
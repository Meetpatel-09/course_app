import 'dart:io';

class RegisterRequestModel {
  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.mobileNo,
    required this.password,
    required this.address,
    required this.userRole,
    required this.profile,
    required this.provider,
  });
  late final String fullName;
  late final String email;
  late final int mobileNo;
  late final String password;
  late final String address;
  late final String userRole;
  late final File profile;
  late final String provider;

  RegisterRequestModel.fromJson(Map<String, dynamic> json){
    fullName = json['full_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    address = json['address'];
    userRole = json['user_role'];
    profile = json['profile'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['full_name'] = fullName;
    _data['email'] = email;
    _data['mobile_no'] = mobileNo;
    _data['password'] = password;
    _data['address'] = address;
    _data['user_role'] = userRole;
    _data['profile'] = profile;
    _data['provider'] = provider;
    return _data;
  }
}
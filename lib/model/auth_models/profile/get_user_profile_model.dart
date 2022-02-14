import 'dart:convert';

GetUserProfileModel getUserProfileJson(String str) =>
    GetUserProfileModel.fromJson(json.decode(str));

class GetUserProfileModel {
  GetUserProfileModel({
    required this.status,
    this.result,
  });
  late final int status;
  late final List<Result>? result;

  GetUserProfileModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.userid,
    required this.fullName,
    required this.email,
    required this.password,
    this.identyProof,
    required this.mobileNo,
    required this.address,
    required this.profile,
    required this.isActive,
    required this.registerDate,
    required this.userRole,
    required this.provider,
    this.accountNo,
    this.accountHolderName,
    this.ifscCode,
  });
  late final int userid;
  late final String fullName;
  late final String email;
  late final String password;
  late final dynamic identyProof;
  late final String mobileNo;
  late final String address;
  late final dynamic profile;
  late final int isActive;
  late final String registerDate;
  late final String userRole;
  late final String provider;
  late final dynamic accountNo;
  late final dynamic accountHolderName;
  late final dynamic ifscCode;

  Result.fromJson(Map<String, dynamic> json){
    userid = json['userid'];
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
    identyProof = null;
    mobileNo = json['mobile_no'];
    address = json['address'];
    profile = json['profile'];
    isActive = json['is_active'];
    registerDate = json['register_date'];
    userRole = json['user_role'];
    provider = json['provider'];
    accountNo = null;
    accountHolderName = null;
    ifscCode = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userid'] = userid;
    _data['full_name'] = fullName;
    _data['email'] = email;
    _data['password'] = password;
    _data['identy_proof'] = identyProof;
    _data['mobile_no'] = mobileNo;
    _data['address'] = address;
    _data['profile'] = profile;
    _data['is_active'] = isActive;
    _data['register_date'] = registerDate;
    _data['user_role'] = userRole;
    _data['provider'] = provider;
    _data['account_no'] = accountNo;
    _data['account_holder_name'] = accountHolderName;
    _data['ifsc_code'] = ifscCode;
    return _data;
  }
}
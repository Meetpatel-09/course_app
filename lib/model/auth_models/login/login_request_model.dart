class LoginRequestModel {
  LoginRequestModel({
    required this.email,
    required this.password,
    required this.provider,
  });
  late final String email;
  late final String password;
  late final String provider;

  LoginRequestModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    password = json['password'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['provider'] = provider;
    return _data;
  }
}
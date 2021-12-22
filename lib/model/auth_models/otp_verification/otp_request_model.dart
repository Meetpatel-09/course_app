class OTPRequestModel {
  OTPRequestModel({
    required this.email,
    required this.otp,
  });
  late final String email;
  late final int otp;

  OTPRequestModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['otp'] = otp;
    return _data;
  }
}
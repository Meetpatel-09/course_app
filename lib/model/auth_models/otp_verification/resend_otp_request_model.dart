class ResendOTPRequestModel {
  ResendOTPRequestModel({
    required this.email,
  });
  late final String email;

  ResendOTPRequestModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    return _data;
  }
}
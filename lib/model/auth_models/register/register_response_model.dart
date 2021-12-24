class RegisterResponseModel {
  RegisterResponseModel({
    required this.status,
    this.msg,
    this.token,
    this.u,
  });
  late final int status;
  late final String? msg;
  late final String? token;
  late final String? u;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    token = json['token'];
    u = json['u'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['token'] = token;
    _data['u'] = u;
    return _data;
  }
}

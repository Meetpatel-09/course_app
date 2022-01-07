class UserSettingsRequestModel {
  UserSettingsRequestModel({
    required this.token,
    this.setExamTimer,
    this.examTimer,
    this.setPerQueTimer,
    this.perQueTimer,
    this.mbid,
  });
  late final String token;
  late final String? setExamTimer;
  late final int? examTimer;
  late final String? setPerQueTimer;
  late final int? perQueTimer;
  late final int? mbid;

  UserSettingsRequestModel.fromJson(Map<String, dynamic> json){
    token = json['token'];
    setExamTimer = json['set_exam_timer'];
    examTimer = json['exam_timer'];
    setPerQueTimer = json['set_per_que_timer'];
    perQueTimer = json['per_que_timer'];
    mbid = json['mbid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['set_exam_timer'] = setExamTimer;
    _data['exam_timer'] = examTimer;
    _data['set_per_que_timer'] = setPerQueTimer;
    _data['per_que_timer'] = perQueTimer;
    _data['mbid'] = mbid;
    return _data;
  }
}
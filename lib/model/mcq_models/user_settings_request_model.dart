class UserSettingsRequestModel {
  UserSettingsRequestModel({
    required this.token,
    this.setExamTimer,
    this.examTimer,
    this.setPerQueTimer,
    this.perQueTimer,
    this.mbid,
    this.queRemainingTime,
    this.queTotalTakenTime,
    this.mcqStartDatetime
  });
  late final String token;
  late final String? setExamTimer;
  late final int? examTimer;
  late final String? setPerQueTimer;
  late final int? perQueTimer;
  late final int? mbid;
  late final List<String>? queRemainingTime;
  late final List<String>? queTotalTakenTime;
  late final bool? mcqStartDatetime;

  UserSettingsRequestModel.fromJson(Map<String, dynamic> json){
    token = json['token'];
    setExamTimer = json['set_exam_timer'];
    examTimer = json['exam_timer'];
    setPerQueTimer = json['set_per_que_timer'];
    perQueTimer = json['per_que_timer'];
    mbid = json['mbid'];
    queRemainingTime = json['que_remaining_time'];
    queTotalTakenTime = json['que_total_taken_time '];
    mcqStartDatetime = json['mcq_start_datetime '];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['set_exam_timer'] = setExamTimer;
    _data['exam_timer'] = examTimer;
    _data['set_per_que_timer'] = setPerQueTimer;
    _data['per_que_timer'] = perQueTimer;
    _data['mbid'] = mbid;
    _data['que_remaining_time'] = queRemainingTime;
    _data['que_total_taken_time '] = queTotalTakenTime;
    _data['mcq_start_datetime'] = mcqStartDatetime;
    return _data;
  }
}
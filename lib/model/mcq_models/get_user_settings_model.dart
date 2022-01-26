import 'dart:convert';

GetUserSettingsModel getUserSettingsModelFromJson(String str) => GetUserSettingsModel.fromJson(json.decode(str));

String getUserSettingsModelToJson(GetUserSettingsModel data) => json.encode(data.toJson());

class GetUserSettingsModel {
  GetUserSettingsModel({
    required this.status,
    this.message,
    this.result,
  });
  late final int status;
  late final String? message;
  late final List<Result>? result;

  GetUserSettingsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['result'] = result?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.userMcqId,
    required this.userid,
    required this.mbid,
    required this.setExamTimer,
    required this.examTimer,
    required this.setPerQueTimer,
    this.perQueTimer,
    this.remainingTime,
    this.completeDate,
    this.mcqStartDatetime,
    this.totalTakenTime,
  });
  late final int userMcqId;
  late final int userid;
  late final int mbid;
  late final String setExamTimer;
  late final int? examTimer;
  late final String setPerQueTimer;
  late final int? perQueTimer;
  late final List? remainingTime;
  late final String? completeDate;
  late final String? mcqStartDatetime;
  late final List? totalTakenTime;

  Result.fromJson(Map<String, dynamic> json){
    userMcqId = json['user_mcq_id'];
    userid = json['userid'];
    mbid = json['mbid'];
    setExamTimer = json['set_exam_timer'];
    examTimer = json['exam_timer'];
    setPerQueTimer = json['set_per_que_timer'];
    perQueTimer = json['per_que_timer'];
    remainingTime = json['remaining_time'];
    completeDate = json['complete_date'];
    mcqStartDatetime = json['mcq_start_datetime'];
    totalTakenTime = json['total_taken_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_mcq_id'] = userMcqId;
    _data['userid'] = userid;
    _data['mbid'] = mbid;
    _data['set_exam_timer'] = setExamTimer;
    _data['exam_timer'] = examTimer;
    _data['set_per_que_timer'] = setPerQueTimer;
    _data['per_que_timer'] = perQueTimer;
    _data['remaining_time'] = remainingTime;
    _data['complete_date'] = completeDate;
    _data['mcq_start_datetime'] = mcqStartDatetime;
    _data['total_taken_time'] = totalTakenTime;
    return _data;
  }
}
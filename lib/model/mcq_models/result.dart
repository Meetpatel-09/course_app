import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      this.userMcqId, 
      this.userid, 
      this.mbid, 
      this.setExamTimer, 
      this.examTimer, 
      this.setPerQueTimer, 
      this.perQueTimer, 
      this.remainingTime, 
      this.completeDate, 
      this.mcqStartDatetime, 
      this.totalTakenTime,});

  Result.fromJson(dynamic json) {
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
  int? userMcqId;
  int? userid;
  int? mbid;
  String? setExamTimer;
  int? examTimer;
  String? setPerQueTimer;
  dynamic perQueTimer;
  dynamic remainingTime;
  String? completeDate;
  dynamic mcqStartDatetime;
  dynamic totalTakenTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_mcq_id'] = userMcqId;
    map['userid'] = userid;
    map['mbid'] = mbid;
    map['set_exam_timer'] = setExamTimer;
    map['exam_timer'] = examTimer;
    map['set_per_que_timer'] = setPerQueTimer;
    map['per_que_timer'] = perQueTimer;
    map['remaining_time'] = remainingTime;
    map['complete_date'] = completeDate;
    map['mcq_start_datetime'] = mcqStartDatetime;
    map['total_taken_time'] = totalTakenTime;
    return map;
  }

}
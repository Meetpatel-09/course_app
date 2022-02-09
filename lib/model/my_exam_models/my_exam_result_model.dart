import 'dart:convert';

MyExamResultModel myExamResultModelFromJson(String str) => MyExamResultModel.fromJson(json.decode(str));

String myExamResultModelToJson(MyExamResultModel data) => json.encode(data.toJson());

class MyExamResultModel {
  MyExamResultModel({
    required this.status,
    this.result,
    this.mcqsetting,
  });
  late final int status;
  late final List<Result>? result;
  late final List<Mcqsetting>? mcqsetting;

  MyExamResultModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
    mcqsetting = List.from(json['mcqsetting']).map((e)=>Mcqsetting.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result?.map((e)=>e.toJson()).toList();
    _data['mcqsetting'] = mcqsetting?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.mcqid,
    required this.mbid,
    required this.que,
    required this.options,
    required this.correctAns,
    required this.ans,
    required this.marks,
    required this.isCorrect,
    this.queRemainingTime,
    this.queTotalTakenTime,
  });
  late final int mcqid;
  late final int mbid;
  late final String que;
  late final List<String> options;
  late final String correctAns;
  late final String ans;
  late final int marks;
  late final bool isCorrect;
  late final Null queRemainingTime;
  late final Null queTotalTakenTime;

  Result.fromJson(Map<String, dynamic> json){
    mcqid = json['mcqid'];
    mbid = json['mbid'];
    que = json['que'];
    options = List.castFrom<dynamic, String>(json['options']);
    correctAns = json['correct_ans'];
    ans = json['ans'];
    marks = json['marks'];
    isCorrect = json['isCorrect'];
    queRemainingTime = null;
    queTotalTakenTime = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mcqid'] = mcqid;
    _data['mbid'] = mbid;
    _data['que'] = que;
    _data['options'] = options;
    _data['correct_ans'] = correctAns;
    _data['ans'] = ans;
    _data['marks'] = marks;
    _data['isCorrect'] = isCorrect;
    _data['que_remaining_time'] = queRemainingTime;
    _data['que_total_taken_time'] = queTotalTakenTime;
    return _data;
  }
}

class Mcqsetting {
  Mcqsetting({
    required this.userMcqId,
    required this.userid,
    required this.mbid,
    required this.setExamTimer,
    required this.examTimer,
    required this.setPerQueTimer,
    this.perQueTimer,
    this.remainingTime,
    required this.completeDate,
    this.mcqStartDatetime,
    this.totalTakenTime,
  });
  late final int userMcqId;
  late final int userid;
  late final int mbid;
  late final String setExamTimer;
  late final int examTimer;
  late final String setPerQueTimer;
  late final Null perQueTimer;
  late final Null remainingTime;
  late final String completeDate;
  late final Null mcqStartDatetime;
  late final Null totalTakenTime;

  Mcqsetting.fromJson(Map<String, dynamic> json){
    userMcqId = json['user_mcq_id'];
    userid = json['userid'];
    mbid = json['mbid'];
    setExamTimer = json['set_exam_timer'];
    examTimer = json['exam_timer'];
    setPerQueTimer = json['set_per_que_timer'];
    perQueTimer = null;
    remainingTime = null;
    completeDate = json['complete_date'];
    mcqStartDatetime = null;
    totalTakenTime = null;
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
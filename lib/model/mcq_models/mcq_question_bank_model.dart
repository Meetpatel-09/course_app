
import 'dart:convert';

MCQQuestionBankModel mcqQuestionBankModelFromJson(String str) => MCQQuestionBankModel.fromJson(json.decode(str));

String mcqQuestionBankModelToJson(MCQQuestionBankModel data) => json.encode(data.toJson());

class MCQQuestionBankModel {
  MCQQuestionBankModel({
    this.status,
    this.result,
  });
  late final int? status;
  late final List<Result>? result;

  MCQQuestionBankModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.mcqid,
    required this.mbid,
    required this.que,
    required this.options,
    required this.marks,
    this.queRemainingTime,
    this.queTotalTakenTime
  });
  late final int mcqid;
  late final int mbid;
  late final String que;
  late final List<String> options;
  late final int marks;
  late final String? queRemainingTime;
  late final String? queTotalTakenTime;

  Result.fromJson(Map<String, dynamic> json){
    mcqid = json['mcqid'];
    mbid = json['mbid'];
    que = json['que'];
    options = List.castFrom<dynamic, String>(json['options']);
    marks = json['marks'];
    queRemainingTime = json['que_remaining_time'];
    queTotalTakenTime = json['que_total_taken_time '];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mcqid'] = mcqid;
    _data['mbid'] = mbid;
    _data['que'] = que;
    _data['options'] = options;
    _data['marks'] = marks;
    _data['que_remaining_time'] = queRemainingTime;
    _data['que_total_taken_time '] = queTotalTakenTime;
    return _data;
  }
}
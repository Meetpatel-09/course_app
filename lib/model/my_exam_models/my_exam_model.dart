import 'dart:convert';

MyExamModel myExamModelFromJson(String str) => MyExamModel.fromJson(json.decode(str));
String myExamModelToJson(MyExamModel data) => json.encode(data.toJson());

class MyExamModel {
  MyExamModel({
    required this.status,
    this.result,
  });
  late final int status;
  late final List<Result>? result;

  MyExamModel.fromJson(Map<String, dynamic> json){
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
    required this.subject,
    required this.subjectid,
    required this.totalMcqBank,
    required this.totalMcqBankAttempted,
  });
  late final String subject;
  late final int subjectid;
  late final int totalMcqBank;
  late final int totalMcqBankAttempted;

  Result.fromJson(Map<String, dynamic> json){
    subject = json['subject'];
    subjectid = json['subjectid'];
    totalMcqBank = json['totalMcqBank'];
    totalMcqBankAttempted = json['totalMcqBankAttempted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subject'] = subject;
    _data['subjectid'] = subjectid;
    _data['totalMcqBank'] = totalMcqBank;
    _data['totalMcqBankAttempted'] = totalMcqBankAttempted;
    return _data;
  }
}
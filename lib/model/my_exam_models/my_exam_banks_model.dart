
import 'dart:convert';

MyExamBanksModel myExamBanksModelFromJson(String str) => MyExamBanksModel.fromJson(json.decode(str));
String myExamBanksModelToJson(MyExamBanksModel data) => json.encode(data.toJson());

class MyExamBanksModel {
  MyExamBanksModel({
    this.status,
    this.result,
  });
  late final int? status;
  late final List<Result>? result;

  MyExamBanksModel.fromJson(Map<String, dynamic> json){
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
    required this.mbid,
    required this.subject,
    required this.subjectid,
    required this.queBankName,
  });
  late final int mbid;
  late final String subject;
  late final int subjectid;
  late final String queBankName;

  Result.fromJson(Map<String, dynamic> json){
    mbid = json['mbid'];
    subject = json['subject'];
    subjectid = json['subjectid'];
    queBankName = json['que_bank_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mbid'] = mbid;
    _data['subject'] = subject;
    _data['subjectid'] = subjectid;
    _data['que_bank_name'] = queBankName;
    return _data;
  }
}
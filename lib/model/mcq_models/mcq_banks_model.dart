
import 'dart:convert';

MCQBanksModel mcqBanksModelFromJson(String str) => MCQBanksModel.fromJson(json.decode(str));

String mcqBanksModelToJson(MCQBanksModel data) => json.encode(data.toJson());

class MCQBanksModel {
  MCQBanksModel({
    this.status,
    this.result,
  });
  late final int? status;
  late final List<Result>? result;

  MCQBanksModel.fromJson(Map<String, dynamic> json){
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
    required this.queBankName,
    required this.subjectid,
    required this.chapterid,
    required this.negatveMarking,
    required this.isFreeMcqBank,
    required this.isActive,
  });
  late final int mbid;
  late final String queBankName;
  late final int subjectid;
  late final int chapterid;
  late final String negatveMarking;
  late final int isFreeMcqBank;
  late final String isActive;

  Result.fromJson(Map<String, dynamic> json){
    mbid = json['mbid'];
    queBankName = json['que_bank_name'];
    subjectid = json['subjectid'];
    chapterid = json['chapterid'];
    negatveMarking = json['negatve_marking'];
    isFreeMcqBank = json['isFreeMcqBank'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mbid'] = mbid;
    _data['que_bank_name'] = queBankName;
    _data['subjectid'] = subjectid;
    _data['chapterid'] = chapterid;
    _data['negatve_marking'] = negatveMarking;
    _data['isFreeMcqBank'] = isFreeMcqBank;
    _data['isActive'] = isActive;
    return _data;
  }
}
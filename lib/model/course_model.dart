// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  CourseModel({
    this.status,
    this.result,
  });

  int? status;
  List<Result>? result;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    status: json["status"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };

}

class Result {
  Result({
    this.cid,
    this.category,
    this.categoryStatus,
    this.categoryCreatedat,
    this.subject,
  });

  int? cid;
  String? category;
  int? categoryStatus;
  DateTime? categoryCreatedat;
  List<Subject>? subject;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    cid: json["cid"],
    category: json["category"],
    categoryStatus: json["category_status"],
    categoryCreatedat: DateTime.parse(json["category_createdat"]),
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "category": category,
    "category_status": categoryStatus,
    "category_createdat": categoryCreatedat!.toIso8601String(),
    "subject": List<dynamic>.from(subject!.map((x) => x.toJson())),
  };
}

class Subject {
  Subject({
    this.subjectid,
    this.cid,
    this.subject,
    this.subjectStatus,
    this.subjectCreatedat,
    this.category,
    this.categoryStatus,
    this.categoryCreatedat,
    this.topic,
  });

  int? subjectid;
  int? cid;
  String? subject;
  int? subjectStatus;
  DateTime? subjectCreatedat;
  String? category;
  int? categoryStatus;
  DateTime? categoryCreatedat;
  List<Topic>? topic;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectid: json["subjectid"],
    cid: json["cid"],
    subject: json["subject"],
    subjectStatus: json["subject_status"],
    subjectCreatedat: DateTime.parse(json["subject_createdat"]),
    category: json["category"],
    categoryStatus: json["category_status"],
    categoryCreatedat: DateTime.parse(json["category_createdat"]),
    topic: List<Topic>.from(json["topic"].map((x) => Topic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjectid": subjectid,
    "cid": cid,
    "subject": subject,
    "subject_status": subjectStatus,
    "subject_createdat": subjectCreatedat!.toIso8601String(),
    "category": category,
    "category_status": categoryStatus,
    "category_createdat": categoryCreatedat!.toIso8601String(),
    "topic": List<dynamic>.from(topic!.map((x) => x.toJson())),
  };
}

class Topic {
  Topic({
    this.topicid,
    this.topic,
    this.subjectid,
    this.topicStatus,
    this.topicCreatedat,
    this.subject,
  });

  int? topicid;
  String? topic;
  int? subjectid;
  int? topicStatus;
  int? topicCreatedat;
  String? subject;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    topicid: json["topicid"],
    topic: json["topic"],
    subjectid: json["subjectid"],
    topicStatus: json["topic_status"],
    topicCreatedat: json["topic_createdat"],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "topicid": topicid,
    "topic": topic,
    "subjectid": subjectid,
    "topic_status": topicStatus,
    "topic_createdat": topicCreatedat,
    "subject": subject,
  };
}

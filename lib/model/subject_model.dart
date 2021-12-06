class SubjectModel {
  late final int? subjectid;
  late final int? cid;
  late final String? subject;
  late final int? subjectStatus;
  late final String? subjectCreatedat;
  late final String? category;
  late final int? categoryStatus;
  late final String? categoryCreatedat;

  SubjectModel({
    this.subjectid,
    this.cid,
    this.subject,
    this.subjectStatus,
    this.subjectCreatedat,
    this.category,
    this.categoryStatus,
    this.categoryCreatedat,
  });

  factory SubjectModel.fromJSon(dynamic json) {
    return SubjectModel(
        subjectid: json['subjectid'],
        cid: json['cid'],
        subject: json['subject'],
        subjectStatus: json['subject_status'],
        subjectCreatedat: json['subject_createdat'],
        category: json['category'],
        categoryStatus: json['category_status'],
        categoryCreatedat: json['category_createdat']);
  }

  static List<SubjectModel> subjectsFtromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return SubjectModel.fromJSon(data);
    }).toList();
  }

  @override
  String toString() {
    return 'SubjectModel {subjectid: $subjectid, cid: $cid, subject: $subject, subjectStatus: $subjectStatus, subjectCreatedat: $subjectCreatedat, category: $category, categoryStatus: $categoryStatus, categoryCreatedat: $categoryCreatedat}';
  }
}

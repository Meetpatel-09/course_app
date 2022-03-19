import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';

class UserMCQSettingsPageWeb extends StatelessWidget {
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String token;
  final int? mbid;
  final String? subjectID;
  const UserMCQSettingsPageWeb({Key? key, this.subjectList, this.subjectIndex, required this.token, this.mbid, this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

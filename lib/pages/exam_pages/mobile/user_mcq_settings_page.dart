import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/exam_chooses_page/exam_chooses.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserMCQSettingsPageMobile extends StatelessWidget {
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String token;
  final int? mbid;
  final String? subjectID;
  const UserMCQSettingsPageMobile({Key? key, this.subjectList, this.subjectIndex, required this.token, this.mbid, this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Exam'.text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
          child: ExamChooses(
              subjectIndex: subjectIndex,
              subjectList: subjectList,
              mbid: mbid,
              token: token,
              subjectID: subjectID
          )
      ),
    );
  }
}
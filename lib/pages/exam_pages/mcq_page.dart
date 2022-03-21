import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/pages/exam_pages/mobile/mcq_page.dart';
import 'package:course_app_ui/pages/exam_pages/web/mcq_page.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as mcq_questions;
import 'package:flutter/foundation.dart' show kIsWeb;

class MCQPage extends StatefulWidget {
  const MCQPage({Key? key}) : super(key: key);

  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  bool wantExamTimer = false;
  bool wantQuestionTimer = false;
  String examTime = "notSet";
  String questionTime = "0";
  late String numQuestions;
  String token = "empty";
  int mbid = 0;
  late List<mcq_questions.Result> mcqQuestionBank = [];
  String userMCQID = "userMCQID";
  late List<Subject> subjectList;
  late int subjectIndex;
  String subjectID = "";

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    token = arg['token'];
    mbid = arg['mbid'];
    examTime = arg['examTime'];
    wantExamTimer = arg['wantExamTimer'];
    wantQuestionTimer = arg['wantQuestionTimer'];
    questionTime = arg['questionTime'];
    numQuestions = arg['numQuestions'];
    mcqQuestionBank = arg['mcqQuestionBank'];
    userMCQID = arg['userMCQID'];
    subjectList = arg['subjectList'];
    subjectIndex = arg['subjectIndex'];
    subjectID = arg['subjectID'];

    if(questionTime == "notSet") {
       questionTime = "0";
    }

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Alert"),
            content: const Text("Do you want to quit exam?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
                },
                child: const Text("Yes")),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No")),
            ],
          )
        );
        return true;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (kIsWeb) {
            // Web SCREEN
            return MCQPageWeb(
                wantExamTimer: wantExamTimer,
                wantQuestionTimer: wantQuestionTimer,
                examTime: examTime,
                questionTime: questionTime,
                numQuestions: numQuestions,
                token: token, mbid: mbid,
                mcqQuestionBank: mcqQuestionBank,
                userMCQID: userMCQID,
                subjectList: subjectList,
                subjectIndex: subjectIndex,
                subjectID: subjectID
            );
          } else {
            // Mobile Screen
            return MCQPageMobile(
              subjectIndex: subjectIndex,
              subjectID: subjectID,
              token: token,
              examTime: examTime,
              mbid: mbid,
              mcqQuestionBank: mcqQuestionBank,
              numQuestions: numQuestions,
              questionTime: questionTime,
              subjectList: subjectList,
              userMCQID: userMCQID,
              wantExamTimer: wantExamTimer,
              wantQuestionTimer: wantQuestionTimer,
            );
          }
        },
      )
    );
  }
}

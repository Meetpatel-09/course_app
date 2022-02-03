import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/mcq_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as mcq_questions;

class MCQPage extends StatefulWidget {
  const MCQPage({Key? key}) : super(key: key);

  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  List<Subject> subjectList = [];
  int index = 0;
  bool wantExamTimer = false;
  bool wantQuestionTimer = false;
  String examTime = "notSet";
  String questionTime = "0";
  late String numQuestions;
  String token = "empty";
  int mbid = 0;
  late List<mcq_questions.Result> mcqQuestionBank = [];
  late PageController controller;
  String userMCQID = "userMCQID";
  late MCQBanksModel mcqBanks;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];
    token = arg['token'];
    mbid = arg['mbid'];
    examTime = arg['examTime'];
    wantExamTimer = arg['wantExamTimer'];
    wantQuestionTimer = arg['wantQuestionTimer'];
    questionTime = arg['questionTime'];
    numQuestions = arg['numQuestions'];
    mcqQuestionBank = arg['mcqQuestionBank'];
    userMCQID = arg['userMCQID'];
    mcqBanks = arg['mcqBanks'];

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
      child: MCQWidget(
        subjectIndex: index,
        subjectList: subjectList,
        mcqBanks: mcqBanks,
        wantExamTimer: wantExamTimer,
        wantQuestionTimer: wantQuestionTimer,
        examTimer: examTime,
        questionTime: questionTime,
        mcqQuestions: mcqQuestionBank,
        mbid: mbid,
        controller: controller,
        token: token,
        userMCQID: userMCQID,
        onChangedPage: (page) {
          if (page == mcqQuestionBank.length - 1) {
            setState(() {
              // btnText = "See Results";
            });
          }
        },
      )
    );
  }
}

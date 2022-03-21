import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/mcq_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as mcq_questions;

class MCQPageMobile extends StatefulWidget {
  final bool wantExamTimer;
  final bool wantQuestionTimer;
  final String examTime;
  final String questionTime;
  final String numQuestions;
  final String token;
  final int mbid;
  final List<mcq_questions.Result> mcqQuestionBank;
  final String userMCQID;
  final List<Subject> subjectList;
  final int subjectIndex;
  final String subjectID;
  const MCQPageMobile({Key? key, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTime, required this.questionTime, required this.numQuestions, required this.token, required this.mbid, required this.mcqQuestionBank, required this.userMCQID, required this.subjectList, required this.subjectIndex, required this.subjectID}) : super(key: key);

  @override
  _MCQPageMobileState createState() => _MCQPageMobileState();
}

class _MCQPageMobileState extends State<MCQPageMobile> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
          wantExamTimer: widget.wantExamTimer,
          wantQuestionTimer: widget.wantQuestionTimer,
          examTimer: widget.examTime,
          questionTime: widget.questionTime,
          mcqQuestions: widget.mcqQuestionBank,
          mbid: widget.mbid,
          controller: controller,
          token: widget.token,
          userMCQID: widget.userMCQID,
          subjectIndex: widget.subjectIndex,
          subjectList: widget.subjectList,
          subjectID: widget.subjectID,
          onChangedPage: (page) {
            if (page == widget.mcqQuestionBank.length - 1) {
              setState(() {
                // btnText = "See Results";
              });
            }
          },
        )
    );
  }
}

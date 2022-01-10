import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/mcq_page2/mcq_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as mcq_questions;
import 'package:velocity_x/velocity_x.dart';

class MCQPage2 extends StatefulWidget {
  const MCQPage2({Key? key}) : super(key: key);

  @override
  _MCQPage2State createState() => _MCQPage2State();
}

class _MCQPage2State extends State<MCQPage2> {
  List<Subject>? subjectList = [];
  int index = 0;
  String wantExamTimer = "No";
  String wantQuestionTimer = "No";
  String examTime = "notSet";
  String questionTime = "notSet";
  late String numQuestions;
  String token = "empty";
  int mbid = 0;
  late List<mcq_questions.Result> mcqQuestionBank = [];
  ValueChanged<String>? onClickedOptions;
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  late PageController controller;

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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Exam".text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: MCQWidget(
        mcqQuestions: mcqQuestionBank,
        controller: controller,
        onChangedPage: (page) {
          if (page == mcqQuestionBank.length - 1) {
            setState(() {
              // btnText = "See Results";
            });
          }
        },
      ),
    );
  }

}

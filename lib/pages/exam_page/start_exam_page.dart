import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as mcq_questions;
import 'package:course_app_ui/widgets/exam/start_exam_page/start_exam_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StartExamPage extends StatefulWidget {
  const StartExamPage({Key? key}) : super(key: key);

  @override
  State<StartExamPage> createState() => _StartExamPageState();
}

class _StartExamPageState extends State<StartExamPage> {
  late List<Subject> subjectList;
  late int index;
  late bool wantExamTimer;
  late bool wantQuestionTimer;
  late String examTime;
  late String questionTime;
  late String numQuestions;
  late String token;
  late int mbid;
  late List<mcq_questions.Result> mcqQuestionsList;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: container(),
        )
      ),
    );
  }

  Widget container() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Align(
        child: nextButton(),
      )
    );
  }

  Widget nextButton() => StartExamButton(
    token: token,
    index: index,
    mbid: mbid,
    subjectList: subjectList,
    wantExamTimer: wantExamTimer,
    examTime: examTime,
    wantQuestionTimer: wantQuestionTimer,
    questionTime: questionTime,
    numQuestions: numQuestions,
  );
}

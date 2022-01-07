import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/options_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as mcq_questions;
import 'package:velocity_x/velocity_x.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({Key? key}) : super(key: key);

  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
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
      body: PageView.builder(
          itemCount: mcqQuestionBank.length,
          itemBuilder: (context, index) {
            final question = mcqQuestionBank[index];

            return buildQuestion(question: question);
          },
        ),
    );
  }

  Widget buildQuestion({required mcq_questions.Result question}) {

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          question.que.richText.semiBold.xl.justify.make(),
          const SizedBox(height: 10,),
          Expanded(
            child: OptionsWidget(
              question: question,
              onClickedOptions: selectOption,
            ),
          )
        ],
      ),
    );
  }

  void selectOption(String option) {
    return;
  }
}

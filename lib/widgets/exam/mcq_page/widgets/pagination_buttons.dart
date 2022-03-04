import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaginationButtons extends StatefulWidget {
  final List<Result> mcqQuestions;
  final int questionIndex;
  final PageController controller;
  final Map<int, String> userAnswer;
  final String token;
  final String userMcqId;
  final Map<int, String> userAnswerToSend;
  final Map<int, Duration> userMCQQuestionTimer;
  final int questionTime;
  final List<int> mcqIDs;
  const PaginationButtons({Key? key, required this.mcqQuestions, required this.questionIndex, required this.controller, required this.userAnswer, required this.token, required this.userMcqId, required this.userAnswerToSend, required this.userMCQQuestionTimer, required this.questionTime, required this.mcqIDs}) : super(key: key);

  @override
  _PaginationButtonsState createState() => _PaginationButtonsState();
}

class _PaginationButtonsState extends State<PaginationButtons> {
  List<bool> isSelected = [];
  List<Widget> toggleButton = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.mcqQuestions.length; i++) {
      if (i == widget.questionIndex) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 6.0),
          child: toggleChild(),
        ),
      ),
    );
  }

  Widget toggleChild() => GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      mainAxisSpacing: 5.0,
      childAspectRatio: 5/3,
    ),
    itemCount: 10,
    itemBuilder: (context, i) {
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.controller.jumpToPage(i);
          });
        },
        child: Container(
            margin: const EdgeInsets.only(right: 5.0, left: 0),
            decoration: BoxDecoration(
              border: Border.all(color: context.primaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: i == widget.questionIndex ? context.primaryColor : context.canvasColor,
            ),
            child: Center(
              child: Text(
                "Q No.-" + (i + 1).toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: i == widget.questionIndex ? MyTheme.white : context.cardColor,
                ),
              ),
            )
        ),
      );
    },
  );
}

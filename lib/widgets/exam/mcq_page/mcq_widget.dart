import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/widgets/button_widget.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/widgets/question_widget/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
  final bool wantExamTimer;
  final bool wantQuestionTimer;
  final List<Result> mcqQuestions;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  const MCQWidget({Key? key, required this.mcqQuestions, required this.controller, required this.onChangedPage, required this.wantExamTimer, required this.wantQuestionTimer}) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int optionIndex = -1;
  String btnText = "Next Question";
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  Map<int, String> userAnswer = {};

  @override
  Widget build(BuildContext context)  => PageView.builder(
    physics: const NeverScrollableScrollPhysics(),
    onPageChanged: widget.onChangedPage,
    controller: widget.controller,
    itemCount: widget.mcqQuestions.length,
    itemBuilder: (context, index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              QuestionWidget(
                question: widget.mcqQuestions[index].que,
                questionNumber: index + 1,
              ),
              const SizedBox(height: 30,),
              Column(
                children: [
                  for (int i = 0; i < 4; i++)
                    GestureDetector(
                      onTap: () {
                        userAnswer[index + 1] = (i + 1).toString();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: context.backgroundColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color:
                                    userAnswer[index + 1] == (i + 1).toString()
                                        ? context.primaryColor
                                        : Colors.black38,
                                    width: 2
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: buildAnswer(i, index),
                            )
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          ButtonWidget(mcqQuestions: widget.mcqQuestions, controller: widget.controller,),
        ],
      );
    },
  );

  Widget buildAnswer(int i, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mcqOptionCodes[i].text.xl.color(
                userAnswer[index + 1] == (i + 1).toString()
                  ? context.primaryColor
                  : Colors.black,
              ).make(),
              const SizedBox(width: 10,),
              SizedBox(width: MediaQuery.of(context).size.width - 150,
                  child: widget.mcqQuestions[index].options[i].text.xl.color(
                    userAnswer[index + 1] == (i + 1).toString()
                        ? context.primaryColor
                        : Colors.black,
                  ).make()
              ),
            ],
          ),
          userAnswer[index + 1] == (i + 1).toString() ?
            Icon(Icons.circle, color: context.primaryColor,)
                :
            const Icon(Icons.circle_outlined, color: Colors.black38,)
    ]
    );
  }

}

import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
  final List<Result> mcqQuestions;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final ValueChanged<String> onClickedOption;
  const MCQWidget({Key? key, required this.mcqQuestions, required this.controller, required this.onChangedPage, required this.onClickedOption}) : super(key: key);

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
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuestionWidget(
              question: widget.mcqQuestions[index].que,
              questionNumber: index + 1,
            ),
            for (int i = 0; i < 4; i++)
              Container(
                width: double.infinity,
                height: 50.0,
                margin: const EdgeInsets.only(
                    bottom: 20.0, left: 12.0, right: 12.0),
                child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: userAnswer.containsKey(index + 1)
                        ?
                    userAnswer[index + 1] == (i + 1).toString()
                        ? Colors.green
                        : Colors.yellow
                        : Colors.yellow,
                    onPressed:  () {
                      userAnswer[index + 1] = (i + 1).toString();
                      setState(() {});
                    },
                    child: buildAnswer(i, index)
                ),
              ),
            const SizedBox(
              height: 40.0,
            ),
            RawMaterialButton(
              onPressed: () {
                if (widget.controller.page?.toInt() == 0) {

                } else {
                  widget.controller.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInExpo);
                }
              },
              shape: const StadiumBorder(),
              fillColor: Colors.blue,
              padding: const EdgeInsets.all(18.0),
              elevation: 0.0,
              child: const Text(
                "previous",
                style: TextStyle(color: Colors.white),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                if (widget.controller.page?.toInt() == widget.mcqQuestions.length - 1) {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ResultScreen(score, userAnswer)));
                } else {
                  widget.controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInExpo);
                }
              },
              shape: const StadiumBorder(),
              fillColor: Colors.blue,
              padding: const EdgeInsets.all(18.0),
              elevation: 0.0,
              child: Text(
                btnText,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    },
  );

  Widget buildAnswer(int i, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mcqOptionCodes[i].text.make(),
          widget.mcqQuestions[index].options[i].text.xl.make(),
          const Icon(Icons.circle_outlined, color: Colors.black38,)
        ],
      ),
    );
  }
}

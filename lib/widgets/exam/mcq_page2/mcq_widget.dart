import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
  final List<Result> mcqQuestions;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  const MCQWidget({Key? key, required this.mcqQuestions, required this.controller, required this.onChangedPage}) : super(key: key);

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
        child: SizedBox(
          height: MediaQuery.of(context).size.height- 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuestionWidget(
                question: widget.mcqQuestions[index].que,
                questionNumber: index + 1,
              ),
              // const SizedBox(height: 30,),
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
                                color: userAnswer.containsKey(index + 1)
                                    ?
                                userAnswer[index + 1] == (i + 1).toString()
                                    ? context.primaryColor
                                    : context.backgroundColor
                                    : context.backgroundColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.black38, width: 2)
                            ),
                            child: buildAnswer(i, index)
                        ),
                      ),
                    ),
                ],
              ),
              // const SizedBox(
              //   height: 40.0,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (widget.controller.page?.toInt() == 0) {

                          } else {
                            widget.controller.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInExpo);
                          }
                        },
                        child: SizedBox(
                          width: 150,
                          child: "Previous".text.lg.center.bold.color(context.primaryColor).make(),
                        )
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
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
                        child: SizedBox(
                          width: 150,
                          child: "Next".text.lg.center.bold.color(context.primaryColor).make(),
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget buildAnswer(int i, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mcqOptionCodes[i].text.xl.make(),
              const SizedBox(width: 10,),
              SizedBox(width: 255, child: widget.mcqQuestions[index].options[i].text.xl.make()),
            ],
          ),
          const Icon(Icons.circle_outlined, color: Colors.black38,)
        ],
      ),
    );
  }

}

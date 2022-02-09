import 'dart:async';

import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/widgets/button_widget.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/widgets/pagination_widget.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final List<Result>? myExamResultList;
  const MCQWidget({Key? key, required this.controller, required this.onChangedPage, this.myExamResultList}) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int optionIndex = -1;
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  int pageIndex = 0;

  static Duration countdownDurationExam = const Duration();
  Duration durationExam = const Duration();
  Timer? timerExam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void reset() {
      setState(() => durationExam = const Duration(hours: 2));
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final seconds = durationExam.inSeconds + addSeconds;

      if(seconds < 0) {
        timerExam?.cancel();
      } else {
        durationExam = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timerExam?.cancel());
  }

  @override
  void dispose() {
    timerExam?.cancel();
    super.dispose();
  }

  void startTimer({bool resets = true}) {
    if(resets) {
      reset();
    }
    timerExam = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Exam".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: widget.onChangedPage,
              controller: widget.controller,
              itemCount: widget.myExamResultList!.length,
              itemBuilder: (context, index) {
                pageIndex = index;
                return SizedBox(
                  height: 555,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        QuestionWidget(
                          question: widget.myExamResultList![pageIndex].que,
                          questionNumber: pageIndex + 1,
                        ),
                        const SizedBox(height: 15,),
                        Column(
                          children: [
                            for (int i = 0; i < 4; i++)
                              GestureDetector(
                                onTap: () {
                                  // if(widget.wantQuestionTimer) {
                                  //   int? s = userMCQQuestionTimer[widget.mcqQuestions[pageIndex].mcqid]?.inSeconds;
                                  //   if (s! != 0) {
                                  //     userAnswer[pageIndex + 1] = (i + 1).toString();
                                  //     userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[pageIndex].options[i];
                                  //     setState(() {});
                                  //   } else {
                                  //     Fluttertoast.showToast(msg: "Question Time Out!!", fontSize: 18);
                                  //   }
                                  // } else {
                                  //   userAnswer[pageIndex + 1] = (i + 1).toString();
                                  //   userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[pageIndex].options[i];
                                  //   setState(() {});
                                  // }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: context.backgroundColor,
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                              color:
                                              widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                                                  ? Colors.green
                                                  : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red : context.cardColor.withOpacity(0.5),
                                              width: 2
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: buildAnswer(i, pageIndex),
                                      )
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonWidget(
                    myExamResultList: widget.myExamResultList,
                    controller: widget.controller,
                  ),
                  PaginationButtons(
                    myExamResultList: widget.myExamResultList,
                    questionIndex: pageIndex,
                    controller: widget.controller,
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  Widget buildAnswer(int i, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mcqOptionCodes[i].text.xl.color(
                widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                    ? Colors.green
                    : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red : context.cardColor,
              ).make(),
              const SizedBox(width: 10,),
              SizedBox(width: MediaQuery.of(context).size.width - 150,
                  child: widget.myExamResultList![index].options[i].text.xl.color(
                    widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
                        ? Colors.green
                        : widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect ? Colors.red : context.cardColor,
                  ).make()
              ),
            ],
          ),
          widget.myExamResultList![index].options[i] == widget.myExamResultList![index].correctAns
              ?
          const Icon(Icons.circle, color: Colors.green,)
              :
          widget.myExamResultList![index].options[i] == widget.myExamResultList![index].ans && !widget.myExamResultList![index].isCorrect
              ?
          const Icon(Icons.circle_outlined, color: Colors.red,)
              :
          Icon(Icons.circle_outlined, color: context.cardColor.withOpacity(0.5),)
        ]
    );
  }
}

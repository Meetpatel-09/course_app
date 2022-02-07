import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as questions;
import 'package:course_app_ui/widgets/exam/mcq_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQPage extends StatefulWidget {
  final bool wantExamTimer;
  final bool wantQuestionTimer;
  final String examTimer;
  final String questionTime;
  final List<questions.Result> mcqQuestions;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final String token;
  final String userMCQID;
  final int mbid;
  final List<Subject> subjectList;
  final int subjectIndex;
  final String subjectID;

  final int optionIndex;
  final String btnText;
  final List<String> mcqOptionCodes;
  final Map<int, String> userAnswer;
  final int pageIndex;
  // user answers
  final Map<int, String> userAnswerToSend;
  final Map<int, Duration> userMCQQuestionTimer;
  final  int mcqId;
  final List<int> mcqIDs;

  final String minutes;
  final String seconds;

  const MCQPage({Key? key, required this.optionIndex, required this.btnText, required this.mcqOptionCodes, required this.userAnswer, required this.pageIndex, required this.userAnswerToSend, required this.userMCQQuestionTimer, required this.mcqId, required this.mcqIDs, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTimer, required this.questionTime, required this.mcqQuestions, required this.controller, required this.onChangedPage, required this.token, required this.userMCQID, required this.mbid, required this.subjectList, required this.subjectIndex, required this.subjectID, required this.minutes, required this.seconds}) : super(key: key);

  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: widget.onChangedPage,
        controller: widget.controller,
        itemCount: widget.mcqQuestions.length,
        itemBuilder: (context, index) {
          pageIndex = index;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 555,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      QuestionWidget(
                        question: widget.mcqQuestions[widget.pageIndex].que,
                        questionNumber: widget.pageIndex + 1,
                        wantExamTimer: widget.wantExamTimer,
                        examTimerMinutes: widget.minutes,
                        examTimerSeconds: widget.seconds,
                        wantQuestionTimer: widget.wantQuestionTimer,
                        questionTime: widget.questionTime,
                        userMCQQuestionTimer: widget.userMCQQuestionTimer,
                        mcqid: widget.mcqQuestions[widget.pageIndex].mcqid,
                      ),
                      const SizedBox(height: 15,),
                      Column(
                        children: [
                          for (int i = 0; i < 4; i++)
                            GestureDetector(
                              onTap: () {
                                if(widget.wantQuestionTimer) {
                                  int? s = widget.userMCQQuestionTimer[widget.mcqQuestions[widget.pageIndex].mcqid]?.inSeconds;
                                  if (s! != 0) {
                                    widget.userAnswer[widget.pageIndex + 1] = (i + 1).toString();
                                    widget.userAnswerToSend[widget.mcqQuestions[widget.pageIndex].mcqid] = widget.mcqQuestions[index].options[i];
                                    setState(() {});
                                  } else {
                                    Fluttertoast.showToast(msg: "Question Time Out!!", fontSize: 18);
                                  }
                                } else {
                                  widget.userAnswer[pageIndex + 1] = (i + 1).toString();
                                  widget.userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[index].options[i];
                                  setState(() {});
                                }
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
                                            widget.userAnswer[pageIndex + 1] ==
                                                (i + 1).toString()
                                                ? context.primaryColor
                                                : context.cardColor.withOpacity(0.5),
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
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildAnswer(int i, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.mcqOptionCodes[i].text.xl.color(
                widget.userAnswer[index + 1] == (i + 1).toString()
                    ? context.primaryColor
                    : context.cardColor,
              ).make(),
              const SizedBox(width: 10,),
              SizedBox(width: MediaQuery.of(context).size.width - 150,
                  child: widget.mcqQuestions[index].options[i].text.xl.color(
                    widget.userAnswer[index + 1] == (i + 1).toString()
                        ? context.primaryColor
                        : context.cardColor,
                  ).make()
              ),
            ],
          ),
          widget.userAnswer[index + 1] == (i + 1).toString() ?
          Icon(Icons.circle, color: context.primaryColor,)
              :
          Icon(Icons.circle_outlined, color: context.cardColor.withOpacity(0.5),)
        ]
    );
  }
}

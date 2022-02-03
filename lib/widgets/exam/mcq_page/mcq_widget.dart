import 'dart:async';

import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as questions;
import 'package:course_app_ui/model/mcq_models/user_answers/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/widgets/button_widget.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/widgets/pagination_buttons.dart';
import 'package:course_app_ui/widgets/exam/mcq_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQWidget extends StatefulWidget {
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
  const MCQWidget({Key? key, required this.mcqQuestions, required this.controller, required this.onChangedPage, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTimer, required this.questionTime, required this.token, required this.userMCQID, required this.mbid}) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int optionIndex = -1;
  String btnText = "Next Question";
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  Map<int, String> userAnswer = {};
  // user answers
  Map<int, String> userAnswerToSend = {};
  Map<int, Duration> userMCQQuestionTimer = {};
  late int mcqId;
  List<int> mcqIDs = [];

  static Duration countdownDurationExam = const Duration();
  Duration durationExam = const Duration();
  Timer? timerExam;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.mcqQuestions.length; i++) {
      mcqIDs.add(widget.mcqQuestions[i].mcqid);
    }
    if (widget.wantExamTimer) {
      startTimer();
    }
  }

  void reset() {
    if (widget.wantExamTimer) {
      countdownDurationExam = Duration(minutes: int.parse(widget.examTimer));
      setState(() => durationExam = countdownDurationExam);
    } else {
      setState(() => durationExam = const Duration(hours: 10));
    }
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final seconds = durationExam.inSeconds + addSeconds;

      if(seconds < 0) {
        timerExam?.cancel();
        sendData(true);
        Future.delayed(Duration.zero, () {
          showTimeOutDialog("Exam Time Out!! Answers submitted", false, false);
        });
      } else {
        durationExam = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if(resets) {
      reset();
    }
    timerExam = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
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

  @override
  Widget build(BuildContext context) {

    // 9 --> 09     11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(durationExam.inMinutes.remainder(60));
    final seconds = twoDigits(durationExam.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: "Exam".text.make(),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.save, size: 25,)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.assignment_turned_in_outlined, size: 25,)),

          TextButton(
            onPressed: () {
              sendData(false);
              showTimeOutDialog("Answers Saved Successfully", false, true);
            },
            child: "Save".text.white.extraBold.size(19).letterSpacing(1).make().pOnly(right: 16, bottom: 0),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
          ),
          TextButton(
            onPressed: () {
              sendData(true);
              showTimeOutDialog("Do you want to finish Exam", true, false);
            },
            child: "Finish".text.white.extraBold.size(19).letterSpacing(1).make().pOnly(right: 16, bottom: 0),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
          )
        ],
      ),
      backgroundColor: context.canvasColor,
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: widget.onChangedPage,
        controller: widget.controller,
        itemCount: widget.mcqQuestions.length,
        itemBuilder: (context, index) {
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
                        question: widget.mcqQuestions[index].que,
                        questionNumber: index + 1,
                        wantExamTimer: widget.wantExamTimer,
                        examTimerMinutes: minutes,
                        examTimerSeconds: seconds,
                        wantQuestionTimer: widget.wantQuestionTimer,
                        questionTime: widget.questionTime,
                        userMCQQuestionTimer: userMCQQuestionTimer,
                        mcqid: widget.mcqQuestions[index].mcqid,
                      ),
                      const SizedBox(height: 15,),
                      Column(
                        children: [
                          for (int i = 0; i < 4; i++)
                            GestureDetector(
                              onTap: () {
                                if(widget.wantQuestionTimer) {
                                  int? s = userMCQQuestionTimer[widget.mcqQuestions[index].mcqid]?.inSeconds;
                                  if (s! != 0) {
                                    userAnswer[index + 1] = (i + 1).toString();
                                    userAnswerToSend[widget.mcqQuestions[index].mcqid] = widget.mcqQuestions[index].options[i];
                                    setState(() {});
                                  } else {
                                    Fluttertoast.showToast(msg: "Question Time Out!!", fontSize: 18);
                                  }
                                } else {
                                  userAnswer[index + 1] = (i + 1).toString();
                                  userAnswerToSend[widget.mcqQuestions[index].mcqid] = widget.mcqQuestions[index].options[i];
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
                                            userAnswer[index + 1] ==
                                                (i + 1).toString()
                                                ? context.primaryColor
                                                : context.cardColor.withOpacity(0.5),
                                            width: 2
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: buildAnswer(i, index),
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
              ButtonWidget(
                mcqIDs: mcqIDs,
                mcqQuestions: widget.mcqQuestions,
                questionIndex: index,
                controller: widget.controller,
                userAnswer: userAnswer,
                token: widget.token,
                userMcqId: widget.userMCQID,
                userAnswerToSend: userAnswerToSend,
                userMCQQuestionTimer: userMCQQuestionTimer,
                questionTime: int.parse(widget.questionTime),
              ),
              PaginationButtons(
                mcqIDs: mcqIDs,
                mcqQuestions: widget.mcqQuestions,
                questionIndex: index,
                controller: widget.controller,
                userAnswer: userAnswer,
                token: widget.token,
                userMcqId: widget.userMCQID,
                userAnswerToSend: userAnswerToSend,
                userMCQQuestionTimer: userMCQQuestionTimer,
                questionTime: int.parse(widget.questionTime),
              ),
            ],
          );
        },
      ),
    );
  }

  showTimeOutDialog(String message, bool isFinished, bool isSave) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: context.backgroundColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  message.text.xl.make(),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isFinished ? TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     MyRoutes.chooseMCQBankRoute,
                            //         (route) => false,
                            //     arguments: {
                            //       'subjectList': widget.subjectList,
                            //       'subjectIndex': widget.subjectIndex,
                            //       // 'mcqBanks': widget.mcqBanks,
                            //     }
                            // );
                            Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
                          },
                          child: "Yes".text.end.make()
                      ) :  TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (!isSave) {
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context,
                              //     MyRoutes.chooseMCQBankRoute,
                              //    (route) => false,
                              //     arguments: {
                              //       'subjectList': widget.subjectList,
                              //       'subjectIndex': widget.subjectIndex,
                              //       // 'mcqBanks': widget.mcqBanks,
                              //     }
                              // );
                              Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
                            }
                          },
                          child: "Ok".text.end.make()
                      ),
                      isFinished ?  TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: "No".text.end.make()
                      ) : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAnswer(int i, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mcqOptionCodes[i].text.xl.color(
                userAnswer[index + 1] == (i + 1).toString()
                  ? context.primaryColor
                  : context.cardColor,
              ).make(),
              const SizedBox(width: 10,),
              SizedBox(width: MediaQuery.of(context).size.width - 150,
                  child: widget.mcqQuestions[index].options[i].text.xl.color(
                    userAnswer[index + 1] == (i + 1).toString()
                        ? context.primaryColor
                        : context.cardColor,
                  ).make()
              ),
            ],
          ),
          userAnswer[index + 1] == (i + 1).toString() ?
            Icon(Icons.circle, color: context.primaryColor,)
                :
          Icon(Icons.circle_outlined, color: context.cardColor.withOpacity(0.5),)
    ]
    );
  }

  sendData(bool isComplete) {
    String na= "";

    Map<int ,String> finalAnswers = {};
    Map<int ,Duration> finalQuestionTime = {};

    for (var element in mcqIDs) {
      finalAnswers[element] = na;
    }

    for (var element in mcqIDs) {
      finalQuestionTime[element] = Duration(seconds: int.parse(widget.questionTime));
    }

    final thirdMap = {
      ...finalAnswers,
      ...userAnswerToSend,
    };

    final thirdMap2 = {
      ...finalQuestionTime,
      ...userMCQQuestionTimer,
    };

    // variables to store mcq questions and answers
    List<int> q = thirdMap.keys.toList();
    List<String> a = thirdMap.values.toList();

    List queRemainingTime = [];
    List queTotalTakenTime = [];

    // checking if there was a question timer
    if(widget.wantQuestionTimer) {

      for(int i = 0; i < thirdMap2.length; i++) {

        int n = widget.mcqQuestions[i].mcqid;
        int? s = thirdMap2[n]?.inSeconds;
        int? r = s!;
        int? t = (int.parse(widget.questionTime) * 60) - r;

        queRemainingTime.add(r);
        queTotalTakenTime.add(t);
      }
    }

    SendUserMCQAnswers model = SendUserMCQAnswers(
      token: widget.token,
      userMcqId: int.parse(widget.userMCQID),
      mbid: widget.mbid,
      ans: a,
      mcqid: q,
      queRemainingTime: queRemainingTime,
      queTotalTakenTime: queTotalTakenTime,
    );

    if (isComplete) {
      APIServices.sendMCQUserAnswer(model, widget.token, true);
    } else {
      APIServices.sendMCQUserAnswer(model, widget.token, false);
    }
  }
}

import 'dart:async';

import 'package:course_app_ui/model/course_model.dart';
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
  final List<Subject> subjectList;
  final int subjectIndex;
  final String subjectID;
  const MCQWidget({Key? key, required this.mcqQuestions, required this.controller, required this.onChangedPage, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTimer, required this.questionTime, required this.token, required this.userMCQID, required this.mbid, required this.subjectList, required this.subjectIndex, required this.subjectID}) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int optionIndex = -1; // for selecting mcq option
  List<String> mcqOptionCodes = ["A", "B", "C", "D"];
  Map<int, String> userAnswer = {};
  int pageIndex = 0;
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
    } else {
      startTimer();
    }
  }

  void reset() {
    if (widget.wantExamTimer) {
      countdownDurationExam = Duration(minutes: int.parse(widget.examTimer));
      setState(() => durationExam = countdownDurationExam);
    } else {
      setState(() => durationExam = const Duration(hours: 2));
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 45,
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
                        height: MediaQuery.of(context).size.height / 1.47,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              QuestionWidget(
                                question: widget.mcqQuestions[pageIndex].que,
                                questionNumber: pageIndex + 1,
                                wantExamTimer: widget.wantExamTimer,
                                examTimerMinutes: minutes,
                                examTimerSeconds: seconds,
                                examTime: widget.examTimer,
                                wantQuestionTimer: widget.wantQuestionTimer,
                                questionTime: widget.questionTime,
                                userMCQQuestionTimer: userMCQQuestionTimer,
                                mcqid: widget.mcqQuestions[pageIndex].mcqid,
                              ),
                              const SizedBox(height: 15,),
                              Column(
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    GestureDetector(
                                      onTap: () {
                                        if(widget.wantQuestionTimer) { // check if there is per question timer
                                          int? s = userMCQQuestionTimer[widget.mcqQuestions[pageIndex].mcqid]?.inSeconds;
                                          if (s! != 0) { // to check if question time is over or not
                                            userAnswer[pageIndex + 1] = (i + 1).toString();
                                            userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[pageIndex].options[i];
                                            setState(() {});
                                          } else {
                                            Fluttertoast.showToast(msg: "Question Time Out!!", fontSize: 18);
                                          }
                                        } else {
                                          userAnswer[pageIndex + 1] = (i + 1).toString();
                                          userAnswerToSend[widget.mcqQuestions[pageIndex].mcqid] = widget.mcqQuestions[pageIndex].options[i];
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
                                                    color: userAnswer[pageIndex + 1] ==
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
                      Column(
                        children: [
                          ButtonWidget(
                            mcqIDs: mcqIDs,
                            mcqQuestions: widget.mcqQuestions,
                            questionIndex: pageIndex,
                            controller: widget.controller,
                            userAnswer: userAnswer,
                            token: widget.token,
                            userMcqId: widget.userMCQID,
                            userAnswerToSend: userAnswerToSend,
                            userMCQQuestionTimer: userMCQQuestionTimer,
                            questionTime: int.parse(widget.questionTime),
                            subjectIndex: widget.subjectIndex,
                            subjectList: widget.subjectList,
                            subjectID: widget.subjectID,
                          ),
                          const SizedBox(height: 5,),
                          PaginationButtons(
                            mcqIDs: mcqIDs,
                            mcqQuestions: widget.mcqQuestions,
                            questionIndex: pageIndex,
                            controller: widget.controller,
                            userAnswer: userAnswer,
                            token: widget.token,
                            userMcqId: widget.userMCQID,
                            userAnswerToSend: userAnswerToSend,
                            userMCQQuestionTimer: userMCQQuestionTimer,
                            questionTime: int.parse(widget.questionTime),
                          ),
                          const SizedBox(height: 5,),
                        ],
                      ),
                    ],
                  );
                },
        ),
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
                            // Navigator.pop(context);
                            APIServices.getMCQBank(widget.subjectID, widget.token, false).then((mcqBanks) {
                              if (mcqBanks.status == 200) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    MyRoutes.chooseMCQBankRoute,
                                    (route) => false,
                                    arguments: {
                                      'subjectList': widget.subjectList,
                                      'subjectIndex': widget.subjectIndex,
                                      'mcqBanks': mcqBanks,
                                      'subjectID': widget.subjectID,
                                      'token': widget.token
                                    }
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Unknown Error"),
                                      content: const Text("This is an error message!!!"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context, MyRoutes.loginRoute);
                                            },
                                            child: const Text("OK")),
                                      ],
                                    )
                                );
                              }
                            });
                          },
                          child: "Yes".text.end.make()
                      ) :  TextButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            if (!isSave) {
                              APIServices.getMCQBank(widget.subjectID, widget.token, false).then((mcqBanks) {
                                if (mcqBanks.status == 200) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      MyRoutes.chooseMCQBankRoute,
                                      (route) => false,
                                      arguments: {
                                        'subjectList': widget.subjectList,
                                        'subjectIndex': widget.subjectIndex,
                                        'mcqBanks': mcqBanks,
                                        'subjectID': widget.subjectID,
                                        'token': widget.token
                                      }
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Unknown Error"),
                                        content: const Text("This is an error message!!!"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushNamed(context, MyRoutes.loginRoute);
                                              },
                                              child: const Text("OK")),
                                        ],
                                      )
                                  );
                                }
                              });
                            } else {
                              Navigator.pop(context);
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
    // variable to set empty in MCQ IDs - MCQ option for those MCQs which are not answered by the user
    String na= "";

    Map<int ,String> finalAnswers = {};
    Map<int ,Duration> finalQuestionTime = {};

    for (var element in mcqIDs) {
      // initially setting all the answers as empty
      finalAnswers[element] = na;
    }

    for (var element in mcqIDs) {
      finalQuestionTime[element] = Duration(seconds: int.parse(widget.questionTime));
    }

    // merging the empty answers with selected answers
    final thirdMap = {
      ...finalAnswers,
      ...userAnswerToSend,
    };

    final thirdMap2 = {
      ...finalQuestionTime,
      ...userMCQQuestionTimer,
    };

    // storing the MCQ ids in a variable 'q'
    List<int> q = thirdMap.keys.toList();
    // storing the MCQ answers in a variable 'a'
    List<String> a = thirdMap.values.toList();

    List queRemainingTime = [];
    List queTotalTakenTime = [];

    // checking if there was a question timer
    if(widget.wantQuestionTimer) {

      for(int i = 0; i < thirdMap2.length; i++) {
        // storing the MCQ ID form the list of MCQ IDs one by one in each iteration for.....
        int n = widget.mcqQuestions[i].mcqid;
        // .... using them to set per question time as per MCQ IDs
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

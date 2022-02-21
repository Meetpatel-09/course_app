import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart' as questions;
import 'package:course_app_ui/model/mcq_models/user_answers/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonWidget extends StatelessWidget {
  final List<questions.Result> mcqQuestions;
  final int questionIndex;
  final PageController controller;
  final Map<int, String> userAnswer;
  final String token;
  final String userMcqId;
  final Map<int, String> userAnswerToSend;
  final Map<int, Duration> userMCQQuestionTimer;
  final int questionTime;
  final List<int> mcqIDs;
  final List<Subject> subjectList;
  final int subjectIndex;
  final String subjectID;
  const ButtonWidget({Key? key, required this.mcqQuestions, required this.controller, required this.userAnswer, required this.questionIndex, required this.token, required this.userMcqId, required this.userAnswerToSend, required this.userMCQQuestionTimer, required this.questionTime, required this.mcqIDs, required this.subjectList, required this.subjectIndex, required this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 6.0, 18.0, 0.0),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                // variable to set empty in MCQ IDs - MCQ option for those MCQs which are not answered by the user
                String na= "";

                Map<int ,String> finalAnswers = {};
                Map<int ,Duration> finalQuestionTime = {};

                for (var element in mcqIDs) {
                  // initially setting all the answers as empty
                  finalAnswers[element] = na;
                }

                for (var element in mcqIDs) {
                  finalQuestionTime[element] = Duration(seconds: questionTime);
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
                if(userMCQQuestionTimer.isNotEmpty) {

                  for(int i = 0; i < thirdMap2.length; i++) {
                    // storing the MCQ ID form the list of MCQ IDs one by one in each iteration for.....
                    int n = mcqQuestions[i].mcqid;
                    // .... using them to set per question time as per MCQ IDs
                    int? s = thirdMap2[n]?.inSeconds;
                    int? r = s!;
                    int? t = (questionTime * 60) - r;

                    queRemainingTime.add(r);
                    queTotalTakenTime.add(t);
                  }
                }

                if (controller.page?.toInt() == 0) {
                  SendUserMCQAnswers model = SendUserMCQAnswers(
                    token: token,
                    userMcqId: int.parse(userMcqId),
                    mbid: mcqQuestions[questionIndex].mbid,
                    ans: a,
                    mcqid: q,
                    queRemainingTime: queRemainingTime,
                    queTotalTakenTime: queTotalTakenTime,
                  );

                  APIServices.sendMCQUserAnswer(model, token, false);
                  controller.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInExpo);
                } else {
                  SendUserMCQAnswers model = SendUserMCQAnswers(
                    token: token,
                    userMcqId: int.parse(userMcqId),
                    mbid: mcqQuestions[questionIndex].mbid,
                    ans: a,
                    mcqid: q,
                    queRemainingTime: queRemainingTime,
                    queTotalTakenTime: queTotalTakenTime,
                  );

                  APIServices.sendMCQUserAnswer(model, token, false);
                  controller.previousPage(
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeInExpo);
                }
              },
              child: const SizedBox(
                width: 100,
                child: Icon(Icons.arrow_back)
              )
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(context.primaryColor.withOpacity(0.2)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                // variable to set empty in MCQ IDs - MCQ option for those MCQs which are not answered by the user
                String na= "";

                Map<int ,String> finalAnswers = {};
                Map<int ,Duration> finalQuestionTime = {};

                for (var element in mcqIDs) {
                  // initially setting all the answers as empty
                  finalAnswers[element] = na;
                }

                for (var element in mcqIDs) {
                  finalQuestionTime[element] = Duration(seconds: questionTime);
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
                if(userMCQQuestionTimer.isNotEmpty) {

                  // mapping the question time
                  for(int i = 0; i < thirdMap2.length; i++) {
                    // storing the MCQ ID form the list of MCQ IDs one by one in each iteration for.....
                    int n = mcqQuestions[i].mcqid;
                    // .... using them to set per question time as per MCQ IDs
                    int? s = thirdMap2[n]?.inSeconds;
                    int? r = s!;
                    int? t = (questionTime * 60) - r;

                    queRemainingTime.add(r);
                    queTotalTakenTime.add(t);
                  }
                }

                if (controller.page?.toInt() == mcqQuestions.length - 1) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        // title: const Text("Unknown Error"),
                        content: const Text("Want to Submit Your Answers?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                SendUserMCQAnswers model = SendUserMCQAnswers(
                                  token: token,
                                  userMcqId: int.parse(userMcqId),
                                  mbid: mcqQuestions[questionIndex].mbid,
                                  ans: a,
                                  mcqid: q,
                                  queRemainingTime: queRemainingTime,
                                  queTotalTakenTime: queTotalTakenTime,
                                );

                                await APIServices.sendMCQUserAnswer(model, token, true).then((response) {
                                  if (response.status == 200) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Congratulations"),
                                          content: const Text("Answers Submitted Successfully"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  APIServices.getMCQBank(subjectID, token).then((mcqBanks) {
                                                    if (mcqBanks.status == 200) {
                                                      Navigator.pushNamedAndRemoveUntil(
                                                          context,
                                                          MyRoutes.chooseMCQBankRoute,
                                                              (route) => false,
                                                          arguments: {
                                                            'subjectList': subjectList,
                                                            'subjectIndex': subjectIndex,
                                                            'mcqBanks': mcqBanks,
                                                            'subjectID': subjectID
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
                                                child: const Text("OK")),
                                          ],
                                        )
                                    );
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(response.status.toString()),
                                          content: Text(response.msg!),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                                                },
                                                child: const Text("OK")),
                                          ],
                                        )
                                    );
                                  }
                                });
                              },
                              child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                        ],
                      )
                  );
                } else {
                  SendUserMCQAnswers model = SendUserMCQAnswers(
                    token: token,
                    userMcqId: int.parse(userMcqId),
                    mbid: mcqQuestions[questionIndex].mbid,
                    ans: a,
                    mcqid: q,
                    queRemainingTime: queRemainingTime,
                    queTotalTakenTime: queTotalTakenTime,
                  );

                  APIServices.sendMCQUserAnswer(model, token, false);
                  controller.nextPage(
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeInExpo);
                }
              },
              child: const SizedBox(
                width: 100,
                child: Icon(Icons.arrow_forward)
              )
          )
        ],
      ),
    );
  }
}

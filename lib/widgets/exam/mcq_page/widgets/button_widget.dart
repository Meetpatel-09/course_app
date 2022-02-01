import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonWidget extends StatelessWidget {
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
  const ButtonWidget({Key? key, required this.mcqQuestions, required this.controller, required this.userAnswer, required this.questionIndex, required this.token, required this.userMcqId, required this.userAnswerToSend, required this.userMCQQuestionTimer, required this.questionTime, required this.mcqIDs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 6),
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
                String na= "";

                Map<int ,String> finalAnswers = {};
                Map<int ,Duration> finalQuestionTime = {};

                for (var element in mcqIDs) {
                  finalAnswers[element] = na;
                }

                for (var element in mcqIDs) {
                  finalQuestionTime[element] = Duration(seconds: questionTime);
                }

                final thirdMap = {
                  ...finalAnswers,
                  ...userAnswerToSend,
                };

                final thirdMap2 = {
                  ...finalQuestionTime,
                  ...userMCQQuestionTimer,
                };


                // print(thirdMap);

                // variables to store mcq questions and answers
                List<int> q = thirdMap.keys.toList();
                List<String> a = thirdMap.values.toList();

                List queRemainingTime = [];
                List queTotalTakenTime = [];
                print(thirdMap2);
                // checking if there was a question timer
                if(userMCQQuestionTimer.isNotEmpty) {

                  print(userMCQQuestionTimer);
                  for(int i = 0; i < thirdMap2.length; i++) {

                    int n = mcqQuestions[i].mcqid;
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
                // print(userAnswerToSend);
                // print(mcqIDs);
                String na= "";

                Map<int ,String> finalAnswers = {};
                Map<int ,Duration> finalQuestionTime = {};

                for (var element in mcqIDs) {
                  finalAnswers[element] = na;
                }

                for (var element in mcqIDs) {
                  finalQuestionTime[element] = Duration(seconds: questionTime);
                }

                final thirdMap = {
                  ...finalAnswers,
                  ...userAnswerToSend,
                };

                final thirdMap2 = {
                  ...finalQuestionTime,
                  ...userMCQQuestionTimer,
                };

                // print(thirdMap);

                // variables to store mcq questions and answers
                List<int> q = thirdMap.keys.toList();
                List<String> a = thirdMap.values.toList();

                List queRemainingTime = [];
                List queTotalTakenTime = [];
                print(thirdMap2);
                // checking if there was a question timer
                if(userMCQQuestionTimer.isNotEmpty) {

                  print(userMCQQuestionTimer);
                  for(int i = 0; i < thirdMap2.length; i++) {

                    int n = mcqQuestions[i].mcqid;
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
                                // print("user_mcq_id $userMcqId");
                                // print("mbid ${mcqQuestions[questionIndex].mbid}");
                                // print(token);
                                // print("mcqIDs $mcqIDs");
                                // print("printed");
                                // print(a);
                                // print("printed a");
                                // print(q);
                                // print("printed q");
                                // print(queTotalTakenTime);
                                // print("printed qtt");
                                // print(queRemainingTime);
                                // print("printed qtr");

                                SendUserMCQAnswers model = SendUserMCQAnswers(
                                  token: token,
                                  userMcqId: int.parse(userMcqId),
                                  mbid: mcqQuestions[questionIndex].mbid,
                                  ans: a,
                                  mcqid: q,
                                  queRemainingTime: queRemainingTime,
                                  queTotalTakenTime: queTotalTakenTime,
                                );
                                print("${model.mbid}, ${model.userMcqId}, ${model.token}, ${model.mcqid}, ${model.queTotalTakenTime}, ${model.queRemainingTime}, ${model.ans} ");

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
                                                  Navigator.pop(context);
                                                  Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
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

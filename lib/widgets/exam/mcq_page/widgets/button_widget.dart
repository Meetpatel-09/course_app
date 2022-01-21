import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

class ButtonWidget extends StatelessWidget {
  final List<Result> mcqQuestions;
  final int questionIndex;
  final PageController controller;
  final Map<int, String> userAnswer;
  final String token;
  final int userMcqId;
  final Map<int, int> userAnswerToSend;
  final Map<int, Duration> userMCQQuestionTimer;
  final int questionTimer;
  final mcqIDs;
  const ButtonWidget({Key? key, required this.mcqQuestions, required this.controller, required this.userAnswer, required this.questionIndex, required this.token, required this.userMcqId, required this.userAnswerToSend, required this.userMCQQuestionTimer, required this.questionTimer, this.mcqIDs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 6),
      child:
      Row(
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
                if (controller.page?.toInt() == 0) {

                } else {
                  controller.previousPage(
                      duration: const Duration(milliseconds: 250),
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
                MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () async {
                if (controller.page?.toInt() == mcqQuestions.length - 1) {

                  // Sorting the mcq question id which are answered in ascending
                  var sortedKeys = userAnswerToSend.keys.toList()..sort();

                  // variables to store mcq questions and answers
                  int key;
                  List q = [];
                  List a = [];

                  // iterating the "Map" of questions and answers
                  for(int i = 0; i < userAnswerToSend.length; i++) {

                    // at each iteration set a 'key' to get the mcq question id
                    key = sortedKeys[i];

                    // in variable 'q' storing the ids of question which are answered
                    q.add(sortedKeys[i]);
                    // in variable 'a' storing the answers of question which are answered
                    a.add(userAnswerToSend[key]);
                  }

                  print(a);

                  List queRemainingTime = [];
                  List queTotalTakenTime = [];

                  // checking if there was a question timer
                  if(userMCQQuestionTimer.isNotEmpty) {

                    for(int i = 0; i < mcqQuestions.length; i++) {

                      int n = mcqQuestions[i].mcqid;
                      int? s = userMCQQuestionTimer[n]?.inSeconds;
                      int? r = s!;
                      int? t = (questionTimer * 60) - r;

                      queRemainingTime.add(r);
                      queTotalTakenTime.add(t);
                    }
                  }

                  // dio.FormData formData;
                  // formData = dio.FormData.fromMap({
                  //   "mcqIds": mcqIDs,
                  //   // "userMcqId": userMcqId,
                  //   // "mbid": mcqQuestions[questionIndex].mbid,
                  //   // "ans": a,
                  //   // "mcqid": q,
                  //   // "queRemainingTime": queRemainingTime,
                  //   // "queTotalTakenTime": queTotalTakenTime,
                  // });

                  // SendUserMCQAnswers model = SendUserMCQAnswers(
                  //   token: token,
                  //   userMcqId: userMcqId,
                  //   mbid: mcqQuestions[questionIndex].mbid,
                  //   ans: a,
                  //   mcqid: q,
                  //   queRemainingTime: queRemainingTime,
                  //   queTotalTakenTime: queTotalTakenTime,
                  //   );

                  var data = {
                  "mcqID": q
                  };

                  await APIServices.sendMCQUserAnswer(data, token).then((response) {
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
                } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 250),
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

import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final List<Result> mcqQuestions;
  final PageController controller;
  final Map<int, String> userAnswer;
  const ButtonWidget({Key? key, required this.mcqQuestions, required this.controller, required this.userAnswer}) : super(key: key);

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
              onPressed: () {
                // if (controller.page?.toInt() == mcqQuestions.length - 1) {
                //   SendUserMCQAnswers model = SendUserMCQAnswers(
                //     mbid: ,
                //     token: ,
                //     ans: ,
                //     mcqid: ,
                //     queRemainingTime: ,
                //     queTotalTakenTime: ,
                //     userMcqId: ,
                //     );
                //
                //   APIServices.sendMCQUserAnswer(model).then((response) {
                //     if (response.status == 200) {
                //       showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             title: const Text("Congratulations"),
                //             content: const Text("Answers Submitted Successfully"),
                //             actions: [
                //               TextButton(
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                     Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
                //                   },
                //                   child: const Text("OK")),
                //             ],
                //           )
                //       );
                //     } else {
                //       showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             title: Text(response.status.toString()),
                //             content: Text(response.msg!),
                //             actions: [
                //               TextButton(
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                     Navigator.pushNamed(context, MyRoutes.homeRoute);
                //                   },
                //                   child: const Text("OK")),
                //             ],
                //           )
                //       );
                //     }
                //   });
                // } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInExpo);
                // }
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

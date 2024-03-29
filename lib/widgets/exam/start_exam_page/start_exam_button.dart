import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

class StartExamButton extends StatelessWidget {
  const StartExamButton({Key? key, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTime, required this.questionTime, required this.numQuestions, required this.token, required this.mbid, required this.userMCQID, this.subjectList, this.subjectIndex, this.subjectID}) : super(key: key);
  final bool wantExamTimer;
  final bool wantQuestionTimer;
  final String examTime;
  final String questionTime;
  final String numQuestions;
  final String token;
  final int mbid;
  final int userMCQID;
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String? subjectID;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
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

            APIServices.getMCQQuestionBank(mbid.toString()).then((response) {
              if (response.status == 200) {
                Navigator.pushNamed(
                    context,
                    MyRoutes.mcqPageRoute,
                    arguments: {
                      'token': token,
                      'mbid': mbid,
                      'wantExamTimer': wantExamTimer,
                      'examTime': examTime,
                      'wantQuestionTimer': wantQuestionTimer,
                      'questionTime': questionTime,
                      'numQuestions': numQuestions,
                      'mcqQuestionBank': response.result,
                      'userMCQID': userMCQID.toString(),
                      'subjectList': subjectList,
                      'subjectIndex': subjectIndex,
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
                              Navigator.pushNamed(context, MyRoutes.homeRoute);
                            },
                            child: const Text("OK")),
                      ],
                    )
                );
              }
            });
          },
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Start Exam",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
          )
      ),
    );
  }
}

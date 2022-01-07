import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

class StartExamButton extends StatelessWidget {
  const StartExamButton({Key? key, required this.subjectList, required this.index, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTime, required this.questionTime, required this.numQuestions, required this.token, required this.mbid}) : super(key: key);
  final List<Subject> subjectList;
  final int index;
  final String wantExamTimer;
  final String wantQuestionTimer;
  final String examTime;
  final String questionTime;
  final String numQuestions;
  final String token;
  final int mbid;

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
          onPressed: () async {
            // Start button with post user mcq settings
            // if (wantExamTimer == "Yes") {
            //   if (wantQuestionTimer == "Yes") {
            //     UserSettingsRequestModel model = UserSettingsRequestModel(
            //         token: token,
            //         setExamTimer: wantExamTimer,
            //         examTimer: int.parse(examTime),
            //         setPerQueTimer: wantQuestionTimer,
            //         perQueTimer: int.parse(questionTime),
            //         mbid: mbid,
            //     );
            //
            //     APIServices.userSettings(model).then((response) {
            //       if (response.status == 200) {
            //         Navigator.push(
            //             context,
            //           MaterialPageRoute (
            //             builder: (BuildContext context) => const TempPage(),
            //           ),
            //         );
            //       } else {
            //         showDialog(
            //             context: context,
            //             builder: (context) => AlertDialog(
            //               title: const Text("Unknown Error"),
            //               content: const Text("This is an error message!!!"),
            //               actions: [
            //                 TextButton(
            //                     onPressed: () {
            //                       Navigator.pop(context);
            //                       Navigator.pushNamed(context, MyRoutes.homeRoute);
            //                     },
            //                     child: const Text("OK")),
            //               ],
            //             )
            //         );
            //       }
            //     });
            //   } else {
            //     UserSettingsRequestModel model = UserSettingsRequestModel(
            //         token: token,
            //         setExamTimer: wantExamTimer,
            //         examTimer: int.parse(examTime),
            //         setPerQueTimer: wantQuestionTimer,
            //         mbid: mbid,
            //     );
            //
            //     APIServices.userSettings(model).then((response) {
            //       if (response.status == 200) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute (
            //             builder: (BuildContext context) => const TempPage(),
            //           ),
            //         );
            //       } else {
            //         showDialog(
            //             context: context,
            //             builder: (context) => AlertDialog(
            //               title: const Text("Unknown Error"),
            //               content: const Text("This is an error message!!!"),
            //               actions: [
            //                 TextButton(
            //                     onPressed: () {
            //                       Navigator.pop(context);
            //                       Navigator.pushNamed(context, MyRoutes.homeRoute);
            //                     },
            //                     child: const Text("OK")),
            //               ],
            //             )
            //         );
            //       }
            //     });
            //   }
            // } else {
            //   UserSettingsRequestModel model = UserSettingsRequestModel(
            //     token: token,
            //     setExamTimer: wantExamTimer,
            //     setPerQueTimer: wantQuestionTimer,
            //     mbid: mbid,
            //   );
            //
            //   APIServices.userSettings(model).then((response) {
            //     if (response.status == 200) {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute (
            //           builder: (BuildContext context) => const TempPage(),
            //         ),
            //       );
            //     } else {
            //       showDialog(
            //           context: context,
            //           builder: (context) => AlertDialog(
            //             title: const Text("Unknown Error"),
            //             content: const Text("This is an error message!!!"),
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
            // }


            // new code

            Navigator.pushNamed(
                context,
                MyRoutes.mcqPageRoute,
                arguments: {
                  'subjectList': subjectList,
                  'index': index,
                  'token': token,
                  'mbid': mbid,
                  'wantExamTimer': wantExamTimer,
                  'examTime': examTime,
                  'wantQuestionTimer': wantQuestionTimer,
                  'questionTime': questionTime,
                  'numQuestions': numQuestions,
                }
            );
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

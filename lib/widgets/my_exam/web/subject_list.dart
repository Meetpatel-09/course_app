import 'package:course_app_ui/model/my_exam_models/my_exam_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectListMyExam extends StatelessWidget {
  final List<Result> subjectList;
  final int subjectIndex;
  final String token;
  final bool isRecent;
  const SubjectListMyExam({Key? key, required this.subjectList, required this.subjectIndex, required this.token, required this.isRecent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int subjectID = subjectList[subjectIndex].subjectid;

    return Container(
      padding: const EdgeInsets.all(15.0),
      width: 300.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.primaryColor),
          color: context.backgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // isRecent ? "${widget.subjectList[widget.subjectIndex].category}".text.bold.size(16).color(context.cardColor).make() : const SizedBox(),
       //   widget.isRecent ? const SizedBox(height: 10,) : const SizedBox(),
          TextButton(
              onPressed: () {
                if (token != "") {
                  APIServices.getMyExamMCQBank(subjectID.toString(), token).then((mcqBanks) {
                    if (mcqBanks.status == 200) {
                      Navigator.pushNamed(
                          context,
                          MyRoutes.chooseMyExamMCQBankRoute,
                          arguments: {
                            'mcqBanks': mcqBanks.result,
                            'subjectID': subjectID.toString()
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
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("User not Logged In"),
                        content: const Text("Please Login with your account to continue"),
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
              },
              child: subjectList[subjectIndex].subject.text.bold.size(18).color(context.cardColor).make()
          ),
          "Total ${subjectList[subjectIndex].totalMcqBankAttempted} MCQ Banks Attempted".text.center.color(context.cardColor.withOpacity(0.5)).make().px(10),
          "Out Of ${subjectList[subjectIndex].totalMcqBank} MCQ Banks".text.center.color(context.cardColor.withOpacity(0.5)).make().px(10),
        ],
      ),
    );
  }
}

import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StartExam extends StatefulWidget {
  final String subjectID;
  final List<Subject> subjectList;
  final int? subjectIndex;
  const StartExam({Key? key, required this.subjectID, this.subjectIndex, required this.subjectList}) : super(key: key);

  @override
  State<StartExam> createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
  final SharedServices _sharedServices = SharedServices();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () {
              // if you to edit this code make sure to do the same in Exam fragment start exam button
              _sharedServices.getData("token").then((value) {
                if (value != null) {
                  return
                    APIServices.getMCQBank(widget.subjectID, value).then((mcqBanks) {
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
                            'token': value
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
                  return showDialog(
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
              });
            },
            child: Text('Start Exam',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.white),
            ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            primary: context.primaryColor,
            elevation: 0,
            shape: const StadiumBorder(),
          ),
        )
    );
  }
}

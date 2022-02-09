import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

class StartExam extends StatefulWidget {
  final String subjectID;
  // final int? subjectIndex;
  const StartExam({Key? key, required this.subjectID}) : super(key: key);

  @override
  _StartExamState createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
  final SharedServices _sharedServices = SharedServices();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            _sharedServices.getData("token").then((value) {
              if (value != null) {
                return APIServices.getMyExamMCQBank(widget.subjectID, value).then((mcqBanks) {
                    if (mcqBanks.status == 200) {
                      Navigator.pushNamed(
                          context,
                          MyRoutes.chooseMyExamMCQBankRoute,
                          arguments: {
                            'mcqBanks': mcqBanks.result,
                            'subjectID': widget.subjectID
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
        )
    );
  }
}

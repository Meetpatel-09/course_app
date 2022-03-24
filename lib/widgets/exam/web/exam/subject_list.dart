import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectList extends StatefulWidget {
  final List<Subject> subjectList;
  final int subjectIndex;
  final String token;
  final bool isRecent;
  const SubjectList({Key? key, required this.subjectList, required this.subjectIndex, required this.token, required this.isRecent}) : super(key: key);

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  @override
  Widget build(BuildContext context) {
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
          widget.isRecent ? "${widget.subjectList[widget.subjectIndex].category}".text.bold.size(16).color(context.cardColor).make()
          : const SizedBox(),
          widget.isRecent ? const SizedBox(height: 10,) : const SizedBox(),
          TextButton(
            onPressed: () {
              if(widget.token != "notSet") {
                APIServices.getMCQBank(
                    widget.subjectList[widget.subjectIndex].subjectid
                        .toString(), widget.token, false).then((mcqBanks) {
                  if (mcqBanks.status == 200) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyRoutes.chooseMCQBankRoute,
                            (route) => false,
                        arguments: {
                          'subjectList': widget.subjectList,
                          'subjectIndex': widget.subjectIndex,
                          'mcqBanks': mcqBanks,
                          'subjectID': widget.subjectList[widget.subjectIndex]
                              .subjectid.toString(),
                          "token": widget.token
                        }
                    );
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: const Text("Unknown Error"),
                              content: const Text(
                                  "This is an error message!!!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, MyRoutes.loginRoute);
                                    },
                                    child: const Text("OK")),
                              ],
                            )
                    );
                  }
                });
              } else {
                APIServices.getMCQBank(
                    widget.subjectList[widget.subjectIndex].subjectid
                        .toString(), widget.token, true).then((mcqBanks) {
                  if (mcqBanks.status == 200) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyRoutes.chooseMCQBankRoute,
                            (route) => false,
                        arguments: {
                          'subjectList': widget.subjectList,
                          'subjectIndex': widget.subjectIndex,
                          'mcqBanks': mcqBanks,
                          'subjectID': widget.subjectList[widget.subjectIndex]
                              .subjectid.toString(),
                          "token": widget.token
                        }
                    );
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: const Text("Unknown Error"),
                              content: const Text(
                                  "This is an error message!!!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, MyRoutes.loginRoute);
                                    },
                                    child: const Text("OK")),
                              ],
                            )
                    );
                  }
                });
              }
            },
            child: "${widget.subjectList[widget.subjectIndex].subject}".text.bold.size(18).color(context.cardColor).make()
          ),
          "Total ${widget.subjectList[widget.subjectIndex].totalMcqInSubject} MCQs".text.lg.color(context.cardColor.withOpacity(0.5)).make().px(10),
        ],
      ),
    );
  }
}

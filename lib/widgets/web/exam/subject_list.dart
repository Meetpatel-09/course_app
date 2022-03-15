import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectList extends StatefulWidget {
  final List<Subject> subjectList;
  final int subjectIndex;
  final String token;
  const SubjectList({Key? key, required this.subjectList, required this.subjectIndex, required this.token}) : super(key: key);

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.primaryColor),
          color: context.backgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              //   APIServices.getMCQBank(subjectID, widget.token).then((mcqBanks) {
              //     if (mcqBanks.status == 200) {
              //       Navigator.pushNamedAndRemoveUntil(
              //           context,
              //           MyRoutes.chooseMCQBankRoute,
              //               (route) => false,
              //           arguments: {
              //             'subjectList': subjectList,
              //             'subjectIndex': subjectIndex,
              //             'mcqBanks': mcqBanks,
              //             'subjectID': subjectID
              //           }
              //       );
              //     } else {
              //       showDialog(
              //           context: context,
              //           builder: (context) =>
              //               AlertDialog(
              //                 title: const Text("Unknown Error"),
              //                 content: const Text("This is an error message!!!"),
              //                 actions: [
              //                   TextButton(
              //                       onPressed: () {
              //                         Navigator.pop(context);
              //                         Navigator.pushNamed(context, MyRoutes.loginRoute);
              //                       },
              //                       child: const Text("OK")),
              //                 ],
              //               )
              //       );
              //     }
              // });
            },
            child: "${widget.subjectList[widget.subjectIndex].subject}".text.bold.size(18).color(context.cardColor).make()
          ),
          "Total ${widget.subjectList[widget.subjectIndex].totalMcqInSubject} MCQs".text.lg.color(context.cardColor.withOpacity(0.5)).make(),
        ],
      ),
    );
  }
}

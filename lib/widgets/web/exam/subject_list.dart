import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/theme/theme.dart';
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
      // height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.primaryColor),
          color: context.backgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              "${widget.subjectList[widget.subjectIndex].subject}".text.bold.size(18).make(),
              "Total ${widget.subjectList[widget.subjectIndex].totalMcqInSubject} MCQs".text.lg.color(context.cardColor.withOpacity(0.5)).make(),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            // Start button to go to MCQ banks page
            child: startExam(subjectID: widget.subjectList[widget.subjectIndex].subjectid.toString(), subjectIndex: widget.subjectIndex, subjectList: widget.subjectList,),
          )
        ],
      ),
    );
  }

  Widget startExam({required String subjectID, required int subjectIndex, required List<Subject> subjectList}) => ElevatedButton(
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
  );
}

import 'package:course_app_ui/model/my_exam_models/my_exam_model.dart';
import 'package:course_app_ui/widgets/my_exam/my_exam_fragment/start_exam.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectList extends StatelessWidget {
  final List<Result> subjectList;
  final int subjectIndex;
  const SubjectList({Key? key, required this.subjectList, required this.subjectIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      height: 115,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: context.primaryColor),
          color: context.backgroundColor
      ),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: subjectList[subjectIndex].subject.richText.bold.size(16).make()
                  ),
                ),
                Align(alignment: Alignment.topLeft, child: "Total ${subjectList[subjectIndex].totalMcqBankAttempted} MCQ Banks Attempted".text.center.color(context.cardColor.withOpacity(0.5)).make()),
                Align(alignment: Alignment.topLeft, child: "Out Of ${subjectList[subjectIndex].totalMcqBank} MCQ Banks".text.center.color(context.cardColor.withOpacity(0.5)).make()),
              ],
            ),
            // Start button go to MCQ banks page
            Align(alignment: Alignment.centerRight, child: StartExam(subjectID: subjectList[subjectIndex].subjectid.toString()),),
          ],
        ),
      ),
    );
  }
}

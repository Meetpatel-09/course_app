import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list/widgets/start_exam.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjectList;
  final int subjectIndex;
  const SubjectList({Key? key, required this.subjectList, required this.subjectIndex}) : super(key: key);

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
            SizedBox(
              height: 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: "${subjectList[subjectIndex].subject}".text.bold.center.size(16).make()
              ),
            ),
            Align(child: "Total ${subjectList[subjectIndex].totalMcqInSubject} MCQs".text.center.color(context.cardColor.withOpacity(0.5)).make()),
            // Start button to go to MCQ banks page
            Align(alignment: Alignment.bottomCenter, child: StartExam(subjectID: subjectList[subjectIndex].subjectid.toString(), subjectIndex: subjectIndex, subjectList: subjectList,)),
          ],
        ),
      );
  }
}

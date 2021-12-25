import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/home/category/widgets/subject_list/widgets/start_exam.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjectList;
  final int index;
  const SubjectList({Key? key, required this.subjectList, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width / 2.3,
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
            height: 110,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(subjectList[index].subject.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ),
          ),
          const SizedBox(height: 5,),
          Align(child: StartExam(subjectList: subjectList, index: index,)),
          ],
        ),
      );
  }
}

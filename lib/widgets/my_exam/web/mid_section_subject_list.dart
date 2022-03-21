import 'package:course_app_ui/model/my_exam_models/my_exam_model.dart';
import 'package:course_app_ui/widgets/my_exam/web/subject_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSectionSubjectList extends StatelessWidget {
  final List<Result> subjectList;
  final String token;
  const MidSectionSubjectList({Key? key, required this.subjectList, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.backgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            // color: Colors.purple,
            padding: const EdgeInsets.only(top: 30.0, left: 55.0, right: 55.0),
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.70,
            ),
            child: Column(
              children: [
                "My Exam".text.xl2.semiBold.make(),
                Container(
                  width: 950,
                  height: 240.0 * (subjectList.length / 3.0),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 6 / 2.6),
                    itemCount: subjectList.length,
                    itemBuilder: (context, index) => SubjectListMyExam(
                        subjectList: subjectList,
                        subjectIndex: index,
                        token: token,
                        isRecent: false),
                  ),
                )
              ],
            ),
          )
        ]));
  }
}

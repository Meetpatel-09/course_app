import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

class StartExam extends StatelessWidget {
  final List<Subject> subjectList;
  final int? index;
  const StartExam({Key? key, required this.subjectList, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.pushNamed(
                context,
                MyRoutes.examRoute,
                arguments: {
                  'subjectList': subjectList,
                  'index': index
                }
            );
          },
        )
    );
  }
}

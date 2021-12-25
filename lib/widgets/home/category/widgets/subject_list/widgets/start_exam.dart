import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StartExam extends StatelessWidget {
  final List<Subject> subjectList;
  final int? index;
  const StartExam({Key? key, required this.subjectList, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
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

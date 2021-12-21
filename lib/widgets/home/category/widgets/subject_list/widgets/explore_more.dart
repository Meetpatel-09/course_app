import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExploreMore extends StatelessWidget {
  final List<Subject> subjectList;
  final int? index;
  const ExploreMore({Key? key, required this.subjectList, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context,
                  MyRoutes.subjectDetailsRoute,
                  arguments: {
                    'subjectList': subjectList,
                    'index': index
                  }
              );
            },
            child: Text('Explore More',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: context.primaryColor),
            )
        )
    );
  }
}

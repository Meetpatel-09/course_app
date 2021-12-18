import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/pages/subject_page/subject_details_page.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExploreMore extends StatelessWidget {
  final List<Subject> subjectList;
  const ExploreMore({Key? key, required this.subjectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectDetailsPage(subjectList: subjectList,),
                  ));
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
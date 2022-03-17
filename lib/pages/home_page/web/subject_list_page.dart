import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/home/web/subject_list/subject_list_mid_section.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';

class SubjectListPage extends StatelessWidget {
  const SubjectListPage({Key? key}) : super(key: key);  // to store the index of category which is selected

  @override
  Widget build(BuildContext context) {
    late List<Result> _coursesList; // to store all the data from from home API
    late List<Subject> _subjectList; // to store the all subject details for the selected category
    late int catIndex;

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    _coursesList = arg['coursesList'];
    _subjectList = arg['subjectList'];
    catIndex = arg['index'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(),
            SubjectListMidSection(catIndex: catIndex, coursesList: _coursesList, subjectList: _subjectList),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }
}

import 'package:course_app_ui/widgets/home/web/subject_list/subject_list_mid_section.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';

class SubjectListPage extends StatelessWidget {
  const SubjectListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CustomNavigationBar(),
            SubjectListMidSection(),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}

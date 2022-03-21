import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/web/user_mcq_settings/mid_section_user_mcq_settings.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserMCQSettingsPageWeb extends StatelessWidget {
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String token;
  final int? mbid;
  final String? subjectID;
  const UserMCQSettingsPageWeb({Key? key, this.subjectList, this.subjectIndex, required this.token, this.mbid, this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(),
            MidSectionUserMCQSettings(token: token, subjectID: subjectID, mbid: mbid, subjectIndex: subjectIndex, subjectList: subjectList),
            const BottomNavigation(),
          ],
        ),
      )
    );
  }
}

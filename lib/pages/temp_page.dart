// import 'package:course_app_ui/widgets/exam/web/mcq_page/mid_section_mcq_page.dart';
// import 'package:course_app_ui/widgets/exam/web/user_mcq_settings/mid_section_user_mcq_settings.dart';
import 'package:course_app_ui/pages/my_profile_pages/web/my_profile_web.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/my_exam/mid_section_my_exam.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TempPage extends StatelessWidget{
  const TempPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CustomNavigationBar(),
            // MidSectionUserMCQSettings(),
            // MidSectionMCQPage(),
            // MidSectionMyExam(),
            MyProfilePageWeb(),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}


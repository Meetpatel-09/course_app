
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/navigation_bar.dart';
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
            // MyProfilePageWeb(),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}


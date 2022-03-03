import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:course_app_ui/widgets/authentication/web/register/mid_section.dart';

class RegisterPageWeb extends StatelessWidget {
  const RegisterPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CustomNavigationBar(),
            MidSection(),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}

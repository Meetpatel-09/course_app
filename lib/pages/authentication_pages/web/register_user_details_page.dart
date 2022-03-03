import 'package:course_app_ui/widgets/authentication/web/user_details/mid_section.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';

class RegisterUserDetailsWeb extends StatelessWidget {
  const RegisterUserDetailsWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CustomNavigationBar(),
            MidSectionUserDetails(),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}

import 'package:course_app_ui/pages/authentication_pages/mobile/register_user_details_page.dart';
import 'package:course_app_ui/pages/authentication_pages/web/register_user_details_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RegisterUserDetailsPage extends StatelessWidget{
  const RegisterUserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return const RegisterUserDetailsWeb();
        } else {
          // Mobile Screen
          return const RegisterUserDetailsMobile();
        }
      },
    );
  }
}

import 'package:course_app_ui/pages/authentication_pages/mobile/register_page.dart';
import 'package:course_app_ui/pages/authentication_pages/web/register_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return const RegisterPageWeb();
        } else {
          // Mobile Screen
          return const RegisterPageMobile();
        }
      },
    );
  }
}

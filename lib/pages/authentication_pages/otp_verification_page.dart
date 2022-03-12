import 'package:course_app_ui/pages/export_pages.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String email = arg['email'];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return OTPVerificationPageWeb(email: email);
        } else {
          // Mobile Screen
          return OTPVerificationPageMobile(email: email);
        }
      },
    );
  }
}
import 'package:course_app_ui/pages/export_pages.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return const LogInPageWeb();
        } else {
          // Mobile Screen
          return const LogInPageMobile();
        }
      },
    );
  }
}

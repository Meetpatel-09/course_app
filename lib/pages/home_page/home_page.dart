import 'package:course_app_ui/pages/home_page/mobile/home_page.dart';
import 'package:course_app_ui/pages/home_page/web/home_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (kIsWeb) {
            // Web SCREEN
            return const HomePageWeb();
          } else {
            // Mobile Screen
            return const HomePageMobile();
          }
        },
    );
  }
}

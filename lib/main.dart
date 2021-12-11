// import 'package:course_app_ui/pages/home_page/home_page.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: loginRoute,
      // home: const HomePage(),
      routes: routes,
    );
  }
}

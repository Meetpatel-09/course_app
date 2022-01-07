import 'package:course_app_ui/pages/export_pages.dart';
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
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splashRoute,
      routes: {
        "/": (context) => const SplashPage(),
        MyRoutes.splashRoute: (context) => const SplashPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.registerRoute: (context) => const RegisterPage(),
        MyRoutes.registerDetailsRoute: (context) => const RegisterUserDetails(),
        MyRoutes.otpVerificationRoute: (context) => const OTPVerificationPage(),
        MyRoutes.userMCQSettingsRoute: (context) => const UserMCQSettingsPage(),
        MyRoutes.startExamRoute: (context) => const StartExamPage(),
        MyRoutes.chooseMCQBankRoute: (context) => const ChooseMCQBankPage(),
        // MyRoutes.tempRoute: (context) => const TempPage(),
      },
    );
  }
}

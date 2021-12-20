import 'package:course_app_ui/pages/authentication_pages/login_page.dart';
import 'package:course_app_ui/pages/authentication_pages/otp_verification_page.dart';
import 'package:course_app_ui/pages/authentication_pages/register_page.dart';
import 'package:course_app_ui/pages/authentication_pages/register_user_details_page.dart';
import 'package:course_app_ui/pages/home_page/mobile/home_page.dart';
import 'package:course_app_ui/pages/splash_page.dart';
import 'package:course_app_ui/pages/subject_page/subject_details_page.dart';
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
      initialRoute: MyRoutes.splashRoute,
      // home: const OTPVerificationPage(),
      routes: {
        // "/": (context) => const HomePage(),
        MyRoutes.splashRoute: (context) => const SplashPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.registerRoute: (context) => const RegisterPage(),
        MyRoutes.registerDetailsRoute: (context) => const RegisterUserDetails(),
        MyRoutes.otpVerificationRoute: (context) => const OTPVerificationPage(),
        MyRoutes.subjectDetailsRoute: (context) => const SubjectDetailsPage(subjectList: []),
      },
    );
  }
}


import 'package:course_app_ui/pages/authentication_pages/mobile/register_page.dart';
import 'package:course_app_ui/pages/authentication_pages/web/register_page.dart';
import 'package:course_app_ui/pages/export_pages.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// view the pubspec.yaml file first for getting the information about the packages used in the project

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // setting the default light
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      // initial route is called when the app is first launched
      initialRoute: MyRoutes.splashRoute,
      routes: {
        "/": (context) => const HomePage(mobileScreenLayout: HomePageMobile(), webScreenLayout: HomePageWeb()),
        MyRoutes.splashRoute: (context) => const SplashPage(),
        MyRoutes.homeRoute: (context) => const HomePage(mobileScreenLayout: HomePageMobile(), webScreenLayout: HomePageWeb()),
        MyRoutes.loginRoute: (context) => const LogInPage(mobileScreenLayout: LogInPageMobile(), webScreenLayout: LogInPageWeb()),
        MyRoutes.registerRoute: (context) => const RegisterPage(mobileScreenLayout: RegisterPageMobile(), webScreenLayout: RegisterPageWeb()),
        MyRoutes.registerDetailsRoute: (context) => const RegisterUserDetails(),
        MyRoutes.otpVerificationRoute: (context) => const OTPVerificationPage(),
        MyRoutes.chooseMCQBankRoute: (context) => const ChooseMCQBankPage(),
        MyRoutes.userMCQSettingsRoute: (context) => const UserMCQSettingsPage(),
        MyRoutes.startExamRoute: (context) => const StartExamPage(),
        MyRoutes.mcqPageRoute: (context) => const MCQPage(),
        MyRoutes.chooseMyExamMCQBankRoute: (context) => const ChooseMyExamMCQBankPage(),
        MyRoutes.myExamMCQPageRoute: (context) => const MyExamMCQPage(),
        MyRoutes.editProfileRoute: (context) => const EditProfilePage(),
      },
    );
  }
}

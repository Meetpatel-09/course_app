import 'package:course_app_ui/pages/authentication_pages/login_page.dart';
import 'package:course_app_ui/pages/authentication_pages/register_page.dart';
import 'package:course_app_ui/pages/home_page/home_page.dart';
import 'package:course_app_ui/pages/splash_page.dart';
import 'package:course_app_ui/pages/subject_page/subject_details_page.dart';

const String splashRoute = "/splash";
const String loginRoute = "/login";
const String registerRoute = "/register";
const String homeRoute = "/home";
const String subjectDetailsRoute = "/subject_detail";

final routes = {
  splashRoute: (context) => const SplashPage(),
  homeRoute: (context) => const HomePage(),
  loginRoute: (context) => const LoginPage(),
  registerRoute: (context) => const RegisterPage(),
  // subjectDetailsRoute: (context) => const SubjectDetailsPage(subjectList: subjectList),
};
import 'package:course_app_ui/pages/authentication_pages/login_page.dart';
import 'package:course_app_ui/pages/authentication_pages/register_page.dart';
import 'package:course_app_ui/pages/home_page/mobile/home_page.dart';
import 'package:course_app_ui/pages/splash_page.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(routes: {
        "/": (_, __) => const MaterialPage(child: SplashPage()),
        // MyRoutes.splashRoute: (_, __) => const MaterialPage(child: SplashPage()),
        MyRoutes.homeRoute: (_, __) => const MaterialPage(child: HomePage()),
        MyRoutes.loginRoute: (_, __) => const MaterialPage(child: LoginPage()),
        MyRoutes.registerRoute: (_, __) => const MaterialPage(child: RegisterPage()),
      }),
      // initialRoute: MyRoutes.splashRoute,
      // // home: const HomePage(),
      // routes: {
      //   // "/": (context) => const HomePage(),
      //   MyRoutes.splashRoute: (context) => const SplashPage(),
      //   MyRoutes.homeRoute: (context) => const HomePage(),
      //   MyRoutes.loginRoute: (context) => const LoginPage(),
      //   MyRoutes.registerRoute: (context) => const RegisterPage(),
      // },
    );
  }
}

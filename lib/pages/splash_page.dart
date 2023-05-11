import 'dart:async';

import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

// Splash page is page which is loaded when the app is launched

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // redirecting to the home page after 2 seconds
    Timer(const Duration(seconds: 2),
            () => Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.loginRoute, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

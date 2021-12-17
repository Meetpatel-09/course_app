
import 'dart:async';

import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    // _sharedServices.checkLogIn("token").then((value) {
      // if (value != null) {
      //   return Timer(const Duration(seconds: 2),
      //           () => Navigator.of(context).pushNamed(homeRoute));
      // } else {
      //   return Timer(const Duration(seconds: 2),
      //           () => Navigator.of(context).pushNamed(loginRoute));
      // }
      Timer(const Duration(seconds: 2),
              () => Navigator.of(context).pushNamed(homeRoute));
    // // }
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 150,
          fit: BoxFit.contain,),
        //   child: Icon(
        //     Icons.app_blocking,
        //   )
        ),
    );
  }
}

import 'package:course_app_ui/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.png",
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10,),
          appName.text.bold.size(25).color(context.primaryColor).make()
        ],
      ),
    );
  }
}

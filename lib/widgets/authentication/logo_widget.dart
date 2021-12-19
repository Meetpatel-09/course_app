import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Image.asset(
        "assets/images/logo.png",
        width: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}

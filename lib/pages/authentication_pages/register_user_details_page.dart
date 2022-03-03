import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RegisterUserDetailsPage extends StatelessWidget{
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const RegisterUserDetailsPage({Key? key, required this.mobileScreenLayout, required this.webScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return webScreenLayout;
        } else {
          // Mobile Screen
          return mobileScreenLayout;
        }
      },
    );
  }
}

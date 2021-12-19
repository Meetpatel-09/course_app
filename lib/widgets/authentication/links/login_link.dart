import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: context.cardColor,
              fontSize: 16.0,
            ),
            children: <TextSpan>[
              const TextSpan(text: "Already have an account? "),
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

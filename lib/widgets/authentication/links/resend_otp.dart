import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ResendOTP extends StatelessWidget {
  const ResendOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: context.cardColor.withOpacity(0.7),
              fontSize: 16.0,
            ),
            children: <TextSpan>[
              const TextSpan(text: "Didn't received the code?"),
              TextSpan(
                text: " RESEND",
                style: TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

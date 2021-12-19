import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: context.cardColor.withOpacity(0.5),
              fontSize: 14.0,
            ),
            children: <TextSpan>[
              const TextSpan(text: "By registering, you confirm that you accept our "),
              TextSpan(
                text: 'Terms of Use and Privacy Policy.',
                style: TextStyle(
                  color: Colors.yellow.shade800,
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

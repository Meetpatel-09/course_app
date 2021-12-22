import 'package:course_app_ui/model/auth_models/otp_verification/resend_otp_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ResendOTP extends StatelessWidget {
  const ResendOTP({Key? key, required this.email}) : super(key: key);
  final String email;

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

                    ResendOTPRequestModel model = ResendOTPRequestModel(email: email);

                    AuthService.resendOTP(model).then((response) {
                      if (response.status == 200) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(Config().appName),
                              content: const Text("OTP sent again."),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                },
                                    child: const Text("OK")),
                              ],
                            )
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(Config().appName),
                              content: Text(response.msg),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: const Text("OK")),
                              ],
                            )
                        );
                      }
                    });
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

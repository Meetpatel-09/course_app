import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, this.isRegisterPage}) : super(key: key);
  final bool? isRegisterPage;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(Colors.red.withOpacity(0.2)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () async {
          final user = await GoogleSignInAPI.login();

          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Sign In Failed'),
            ));
          } else {
            if(isRegisterPage! == true) {
              Navigator.pushNamed(
                  context,
                  MyRoutes.registerDetailsRoute,
                  arguments: {
                    'email': user.email, 'isGoogle': "yes", 'name': user.displayName
                  }
              );
            } else {
              LoginRequestModel model = LoginRequestModel(
                email: user.email,
                password: 'Google',
                provider: 'Google',
              );

              AuthService.login(model).then((response) async {
                if (response.status == 200) {
                  String token = response.token.toString();
                  setToken(token);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    MyRoutes.homeRoute,
                        (route) => false,
                      arguments: {
                        'isGoogle': "yes"
                      }
                  );
                } else {
                  if (response.redirect == 1) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(Config().appName),
                          content: const Text("Resend and Verify OTP"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      MyRoutes.otpVerificationRoute,
                                      (route) => false, arguments: {
                                          'email': user.email,
                                      }
                                  );
                                  GoogleSignInAPI.logout();
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
                          content: Text(response.msg!),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  GoogleSignInAPI.logout();
                                },
                                child: const Text("OK")),
                          ],
                        )
                    );
                  }
                }
              });
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(65, 0, 65, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                image: AssetImage(
                    "assets/images/google-plus-login-icon-24.png"),
                height: 35.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

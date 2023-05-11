import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class GButton extends StatelessWidget {
  // this google button widget is used in both login and register page
  // so, to check if it is pressed form form login or register page
  final bool isRegisterPage;
  const GButton({Key? key, required this.isRegisterPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        "Continue with    ".text.xl.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
        Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(color: context.cardColor.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(17.5)
            ),
            // child: Image.asset("assets/images/g.png")
            child: TextButton(
              onPressed: () async {
                final user = await GoogleSignInAPI.login();
                // when is user not found on google api
                if (user == null) {
                  Fluttertoast.showToast(msg: 'Sign In Failed', toastLength: Toast.LENGTH_LONG, fontSize: 16.0);
                } else {
                  // when the button is pressed on register button
                  if(isRegisterPage == true) {
                    Navigator.pushNamed(
                        context,
                        MyRoutes.registerDetailsRoute,
                        arguments: {
                          'email': user.email, 'isGoogle': "yes", 'name': user.displayName
                        }
                    );
                  } else { // when the button is pressed on login button
                    LoginRequestModel model = LoginRequestModel(
                      email: user.email,
                      password: 'Google',
                      // provider: 'Google',
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
              child: Image.asset("assets/images/g.png"))
            ),
      ],
    );
  }

  // Storing the user token and isGoogle as 'Yes' for future reference
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('isGoogle', 'Yes');
  }
}

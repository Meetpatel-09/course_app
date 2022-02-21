import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class LogoutIconButton extends StatefulWidget {
  const LogoutIconButton({Key? key}) : super(key: key);

  @override
  State<LogoutIconButton> createState() => _LogoutIconButtonState();
}

class _LogoutIconButtonState extends State<LogoutIconButton> {
  final SharedServices _sharedServices = SharedServices();

  bool isLoggedIn = false;
  String isGoogle = "no";

  @override
  void initState() {
    super.initState();
    // checking the token to verify if the user is signed
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
    // checking if the user have singed in/up using google
    _sharedServices.getData("isGoogle").then((value) {
      if (value != null) {
        setState(() {
          isGoogle = "yes";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? IconButton(
        onPressed: () async {
          // removing the token
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          if (isGoogle == "yes") {
            // if yes then, calling the logout method form GoogleSignInAPI dart file previously created
            await GoogleSignInAPI.logout();
          }
          // redirecting the use to sign in page
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.loginRoute,
            (route) => false,
          );
        },
        icon: const Icon(Icons.logout)
    ) :  TextButton(
      onPressed: () {
        // redirecting the use to sign in page
        Navigator.pushNamedAndRemoveUntil(
          context,
          MyRoutes.loginRoute,
          (route) => false,
        );
      },
      child: "Sign In".text.white.xl.bold.letterSpacing(1).make().px(16),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}

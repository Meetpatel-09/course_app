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
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          if (isGoogle == "yes") {
            await GoogleSignInAPI.logout();
          }
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.loginRoute,
            (route) => false,
          );
        },
        icon: const Icon(Icons.logout)
    ) :  TextButton(
      onPressed: () {
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

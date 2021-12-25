import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: ()  async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      await GoogleSignInAPI.logout();
      Navigator.pushNamedAndRemoveUntil(
        context,
        MyRoutes.loginRoute,
            (route) => false,
      );
    },
        icon: const Icon(Icons.logout)
    );
  }
}

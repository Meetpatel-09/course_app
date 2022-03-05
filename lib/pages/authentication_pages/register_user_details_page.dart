import 'package:course_app_ui/pages/authentication_pages/mobile/register_user_details_page.dart';
import 'package:course_app_ui/pages/authentication_pages/web/register_user_details_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RegisterUserDetailsPage extends StatelessWidget{
  const RegisterUserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    String isGoogle = "no";
    String name = "";

    // // Getting the arguments send from the registration page and/or google button on registration page
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // email = arg['email'];
    // password = arg['password'];
    // // Checking is user has registered with Google
    // if (arg['isGoogle'] != null) {
    //   isGoogle = arg['isGoogle'];
    //   // Getting the name
    //   name = arg['name'];
    // }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          // return RegisterUserDetailsWeb(email: email!, password: password!, isGoogle: isGoogle, name: name,);
          return const RegisterUserDetailsWeb();
        } else {
          // Mobile Screen
          return RegisterUserDetailsMobile(email: email!, password: password!, isGoogle: isGoogle, name: name,);
        }
      },
    );
  }
}

import 'dart:io';

import 'package:course_app_ui/pages/my_profile_pages/mobile/edit_profile_page.dart';
import 'package:course_app_ui/pages/my_profile_pages/web/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = "";
  String mobileNo = "";
  String address = "";
  String token = "";
  String userImageString = "";

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    name = arg['name'];
    mobileNo = arg['mobileNo'];
    address = arg['address'];
    token = arg['token'];
    userImageString = arg['image'];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return EditProfilePageWeb(name: name, token: token, address: address, mobileNo: mobileNo, userImageString: userImageString,);
        } else {
          // Mobile Screen
          return EditProfilePageMobile(name: name, token: token, address: address, mobileNo: mobileNo, userImageString: userImageString,);
        }
      },
    );
  }

}

import 'dart:io';

import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/links/terms_conditions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUserDetails extends StatefulWidget {
  const RegisterUserDetails({Key? key,})
      : super(key: key);

  @override
  _RegisterUserDetailsState createState() => _RegisterUserDetailsState();
}

class _RegisterUserDetailsState extends State<RegisterUserDetails> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String? email;
  String? password;
  String isGoogle = "no";
  String name = "";
  List<String> fullName = [];
  String? phoneNo;
  String? address;
  File? image;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    email = arg['email'];
    password = arg['password'];
    if (arg['isGoogle'] != null) {
      isGoogle = arg['isGoogle'];
      name = arg['name'];
      fullName = name.split(" ");
      firstName = fullName[0];
      lastName = fullName[1];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        iconTheme: IconThemeData(color: context.primaryColor),
        title: "Complete Profile".text.color(context.primaryColor).make(),
      ),
      backgroundColor: context.canvasColor,
      body: ProgressHUD(
          child: Form(key: globalFormKey, child: _takeDetailsUI(context)),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
    );
  }

  Widget _takeDetailsUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          formFields(),
          const SizedBox(height: 5,),
          const TermsAndConditions().px20(),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }

  Widget formFields() {
    return Column(
      children: [
        Stack(
          children: [
            image != null ? userImage() : buildImage(),
            Positioned(
                bottom: 0,
                right: 4,
                child: buildAddImageIcon()
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Align(child: "Profile Picture".text.lg.center.make()),
        const SizedBox(height: 30,),
        FormHelper.inputFieldWidget(
          context,
          const Icon(Icons.person),
          "f_name",
          "First Name",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "First Name cannot be empty.";
            }
            return null;
          },
              (onSavedVal) {
            firstName = onSavedVal;
          },
          initialValue: firstName,
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
          context,
          const Icon(Icons.person),
          "l_name",
          "Last Name",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Last Name cannot be empty.";
            }
            return null;
          },
              (onSavedVal) {
            lastName = onSavedVal;
          },
          initialValue: lastName,
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
          context,
          const Icon(Icons.phone_android),
          "p_number",
          "Phone Number",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Phone Number cannot be empty.";
            }
            try {
              int pNumber = int.parse(onValidateVal);
              if (pNumber > 1111111111 && pNumber < 9999999999) {
                return null;
              } else {
                return "Enter valid Phone Number";
              }
            } catch(e) {
              return "Enter valid Phone Number";
            }

          },
              (onSavedVal) {
            phoneNo = onSavedVal;
          },
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        FormHelper.inputFieldWidget(
          context,
          const Icon(Icons.home),
          "address",
          "Address",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Address cannot be empty.";
            }
            return null;
          },
              (onSavedVal) {
            address = onSavedVal;
          },
          isMultiline: true,
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: FormHelper.submitButton(
            "Register", () async {
              if (validateAndSave()) {
                  setState(() {
                    isAPICallProcess = true;
                  });
                  dio.FormData formData;
                  if (isGoogle == "yes") {
                    print(email);
                    print(isGoogle);
                    formData = dio.FormData.fromMap({
                      "full_name": firstName + " " + lastName,
                      "email": email,
                      "mobile_no": phoneNo,
                      "address": address,
                      "user_role": 'user',
                      "profile": await dio.MultipartFile.fromFile(image!.path,
                          filename: image!.path.split('/').last),
                      "provider": 'Google'
                    });

                    AuthService.googleRegister(formData).then((response) async {
                      print(response.status);
                      setState(() {
                        isAPICallProcess = false;
                      });
                      if(response.status == 200) {
                        String token = response.token.toString();
                        print(response.status);
                        setToken(token);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          MyRoutes.homeRoute,
                              (route) => false,
                        );
                      } else {
                        print(response.status);
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config().appName,
                          response.msg!,
                          "OK",
                              () {
                            Navigator.pop(context);
                            GoogleSignInAPI.logout();
                          },
                        );
                      }
                    });
                  } else {
                    formData = dio.FormData.fromMap({
                      "full_name": firstName + " " + lastName,
                      "email": email,
                      "mobile_no": phoneNo,
                      "password": password,
                      "address": address,
                      "user_role": 'user',
                      "profile": await dio.MultipartFile.fromFile(image!.path,
                          filename: image!.path.split('/').last),
                      "provider": 'VPSMCQ'
                    });

                    AuthService.register(formData).then((response) async {
                      print(response.status);
                      setState(() {
                        isAPICallProcess = false;
                      });
                      if(response.status == 200) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            MyRoutes.otpVerificationRoute,
                            (route) => false,
                            arguments: {
                              'email': email,
                            }
                        );
                      } else {
                        print(response.status);
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config().appName,
                          response.msg!,
                          "OK",
                              () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    });
                  }
              }
            },
            width: MediaQuery.of(context).size.width - 40,
            btnColor: context.primaryColor,
            borderColor: context.cardColor,
            txtColor: MyTheme.white,
            borderRadius: 10,
          ),
        ),
      ],
    );
  }

  Widget userImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: FileImage(image!),
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          child: InkWell(onTap: () => pickImage(),),
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: const AssetImage("assets/images/profile.png"),
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          child: InkWell(onTap: () => pickImage(),),
        ),
      ),
    );
  }

  Widget buildAddImageIcon() => buildCircle(
      color: context.canvasColor,
      all: 3,
      child: buildCircle(
        color: context.primaryColor,
        all: 0,
        child: IconButton(
          icon: const Icon(Icons.add_a_photo),
          iconSize: 22,
          color: Colors.white,
          onPressed: () => pickImage(),
        ),
      )
  );

  buildCircle({
    required Color color,
    required double all,
    required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  // Getting the profile picture of the user
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      // Images stored in chase memory temporary
      final imageTemporary = File(image.path);
      // print(image.saveTo("assets/images/"));
      setState(() => this.image = imageTemporary);

    } catch(e) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config().appName,
        e.toString(),
        "OK", () {
        Navigator.of(context).pop();
      },
      );
    }
  }

  // Validating the fields of the form
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (image == null) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config().appName,
        "Please select a profile image",
        "OK", () {
          Navigator.pop(context);
        },
      );
      return false;
    } else {
      form!.save();
      if (form.validate()) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

}

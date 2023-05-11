import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/auth_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSection extends StatefulWidget {
  const MidSection({Key? key}) : super(key: key);

  @override
  State<MidSection> createState() => _MidSectionState();
}

class _MidSectionState extends State<MidSection> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: 1500,
          minHeight: MediaQuery.of(context).size.height - 125
      ),
      color: context.backgroundColor,
      // used the 'snippet_coder_utils' package for form
      // https://pub.dev/packages/snippet_coder_utils
      // from more details visit the above URL.
      child: ProgressHUD(
        child: Form(key: globalFormKey, child: _loginUI(context)),
        inAsyncCall: isAPICallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const LogoWidget(),
          const SizedBox(height: 25,),
          Align(child: "Log In".text.semiBold.xl5.color(context.primaryColor).make()),
          const SizedBox(height: 30,),
          formFields(),
          const SizedBox(height: 25,),
          // const FacebookButton(),
          // const SizedBox(height: 65,),
          const GoogleButton(isRegisterPage: false,),
          const SizedBox(height: 15,),
          const RegisterLink(),
          const SizedBox(height: 25,),
        ],
      ),
    );
  }

  Widget formFields() => Container(
    constraints: const BoxConstraints(
      maxWidth: 500,
    ),
    child: Column(
      children: [
        FormHelper.inputFieldWidget(
          context,
          "email",
          "Email",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Email cannot be empty.";
            }
            return null;
          },
              (onSavedVal) {
            email = onSavedVal;
          },
          // paddingTop: 10,
          // paddingBottom: 10,
          showPrefixIcon: true,
          prefixIconPaddingLeft: 20.0,
          prefixIconPaddingTop: 20.0,
          prefixIconPaddingBottom: 20.0,
          prefixIcon: const Icon(Icons.person),
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
        ),
        const SizedBox(height: 15,),
        FormHelper.inputFieldWidget(
          context,
          "password",
          "Password",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Password cannot be empty.";
            }
            return null;
          },
              (onSavedVal) {
            password = onSavedVal;
          },
          showPrefixIcon: true,
          prefixIconPaddingLeft: 20.0,
          prefixIconPaddingTop: 20.0,
          prefixIconPaddingBottom: 20.0,
          prefixIcon: const Icon(Icons.lock,),
          prefixIconColor:context.cardColor,
          borderFocusColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(right: 25),
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            color: context.cardColor.withOpacity(0.7),
            icon:
            Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        const SizedBox(height: 15,),
        Align(
          alignment: Alignment.centerRight,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: context.cardColor,
                fontSize: 16.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Forget Password?',
                  style: TextStyle(
                    color: context.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // print("Forget Password");
                    },
                ),
              ],
            ),
          ),
        ).pOnly(right: 22),
        const SizedBox(height: 15,),
        Center(
          child: FormHelper.submitButton(
            "Login",
                () {
              if (validateAndSave()) {
                setState(() {
                  isAPICallProcess = true;
                });

                LoginRequestModel model = LoginRequestModel(
                  email: email!,
                  password: password!,
                  // provider: 'VPSMCQ',
                );

                AuthService.login(model).then((response) async {
                  setState(() {
                    isAPICallProcess = false;
                  });
                  if (response.status == 200) {
                    String token = response.token.toString();
                    setToken(token);
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyRoutes.homeRoute,
                            (route) => false,
                        arguments: {
                          'isGoogle': "no"
                        }
                    );
                  } else {
                    if (response.redirect == 1) {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config().appName,
                        response.msg!,
                        "Resend and Verify OTP",
                            () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              MyRoutes.otpVerificationRoute,
                                  (route) => false, arguments: {
                            'email': email,
                          }
                          );
                        },
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
                                },
                                child: const Text("OK")),
                          ],
                        )
                      );
                    }
                  }
                });
              }
            },
            width: MediaQuery.of(context).size.width - 40,
            // height: 60,
            btnColor: context.primaryColor,
            borderColor: context.cardColor,
            txtColor: MyTheme.white,
            borderRadius: 10,
          ),
        ).pSymmetric(h: 20),
        const SizedBox(height: 25,),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: context.cardColor,
                fontSize: 16.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'OR',
                  style: TextStyle(
                    color: context.cardColor.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // print("Forget Password");
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ).centered();

  // Validating the fields of the form
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // Storing the user token for future reference
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

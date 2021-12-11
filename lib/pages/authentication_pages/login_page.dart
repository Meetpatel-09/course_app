import 'package:course_app_ui/model/auth_models/login_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/widgets/authentication/buttons/facebook_button.dart';
import 'package:course_app_ui/widgets/authentication/buttons/google_button.dart';
import 'package:course_app_ui/widgets/authentication/logo_widget.dart';
import 'package:course_app_ui/widgets/authentication/text/register_link.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.canvasColor,
        body: SingleChildScrollView(
          child: ProgressHUD(
            child: Form(key: globalFormKey, child: _loginUI(context)),
            inAsyncCall: isAPICallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LogoWidget(),
          const SizedBox(height: 35,),
          FormHelper.inputFieldWidget(
            context,
            const Icon(Icons.person),
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
            borderFocusColor: context.cardColor,
            prefixIconColor: context.cardColor,
            borderColor: context.cardColor,
            textColor: context.cardColor,
            hintColor: context.cardColor.withOpacity(0.7),
            borderRadius: 10,
          ),
          const SizedBox(height: 10,),
          FormHelper.inputFieldWidget(
            context,
            const Icon(Icons.lock,),
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
            borderFocusColor: context.cardColor,
            prefixIconColor:context.cardColor,
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
                  );

                  AuthService.login(model).then((response) async {
                    setState(() {
                      isAPICallProcess = false;
                    });
                    if (response.msg == null) {
                      String token = response.token.toString();
                      setToken(token);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                            (route) => false,
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        appName,
                        "Invalid Email/Password !",
                        "OK",
                            () {
                          Navigator.pop(context);
                        },
                      );
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
          ),
          const SizedBox(
            height: 30,
          ),
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
                      text: 'Forget Password?',
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
          // Center(child: 'OR'.text.bold.size(18).color(context.cardColor).make(),),
          const SizedBox(
            height: 25,
          ),
          const FacebookButton(),
          const SizedBox(
            height: 15,
          ),
          const GoogleButton(),
          const SizedBox(
            height: 25,
          ),
          const RegisterLink(),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      // return true;
      return false;
    } else {
      return false;
    }
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

}

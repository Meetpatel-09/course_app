import 'package:course_app_ui/model/auth_models/login/login_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/web/buttons/g_button.dart';
import 'package:course_app_ui/widgets/web/navigation_bar//auth_navigation_bar.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class LogInPageWeb extends StatefulWidget {
  const LogInPageWeb({Key? key}) : super(key: key);

  @override
  State<LogInPageWeb> createState() => _LogInPageWebState();
}

class _LogInPageWebState extends State<LogInPageWeb> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: ResponsiveWidget.isSmallScreen(context)
          ?
      SingleChildScrollView(
        child: Column(
          children: [
            const AuthNavigationBar(fromLogIn: true),
            loginUI(context).p(16.0),
            const BottomNavigation(),
          ],
        ),
      )
          :
      Stack(
          children: [
            bgImage(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const AuthNavigationBar(fromLogIn: true),
                  Stack(
                    children: [
                      bgImage2(),
                      midSection(),
                    ],
                  ),
                  const BottomNavigation(),
                ],
              ),
            ),
          ]
      ).centered(),
    );
  }

  Widget midSection() {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 2,
        right: MediaQuery.of(context).size.width / 15,
      ),
      child: loginUI(context),
    );
  }

  Widget bgImage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2.25
      ),
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.2),
      ),
    );
  }

  Widget bgImage2() {
    return Container(
      height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2.25
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg4.png'),
            // <a href='https://www.freepik.com/vectors/education'>Education vector created by storyset - www.freepik.com</a>
            // colorFilter: ColorFilter.mode(context.backgroundColor.withOpacity(0.4), BlendMode.modulate,)
          )
      ),
    );
  }

  Widget loginUI(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          formFields(),
          const GButton(isRegisterPage: false),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget formFields() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      'Welcome to Course App'.text.bold.size(30).color(context.cardColor).make(),
      'Log In to Your Account'.text.lg.color(context.cardColor.withOpacity(0.7)).make(),
      const SizedBox(height: 30,),
      "Email".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
      const SizedBox(height: 10),
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
        paddingLeft: 0.0,
        paddingRight: 0.0,
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
      "Password".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
      const SizedBox(height: 10,),
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
        paddingLeft: 0.0,
        paddingRight: 0.0,
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
      FormHelper.submitButton(
        "Login",
            () {
          if (validateAndSave()) {
            setState(() {
              isAPICallProcess = true;
            });

            LoginRequestModel model = LoginRequestModel(
              email: email!,
              password: password!,
              provider: 'VPSMCQ',
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
        width: 200,
        height: 60,
        btnColor: context.primaryColor,
        borderColor: Colors.lightBlue.shade800,
        txtColor: MyTheme.white,
        borderRadius: 30,
      ).pSymmetric(h: 20),
      const SizedBox(height: 25,),
    ],
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

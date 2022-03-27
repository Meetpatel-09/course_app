import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/web/buttons/g_button.dart';
import 'package:course_app_ui/widgets/authentication/text/create_account_web.dart';
import 'package:course_app_ui/widgets/web/navigation_bar//auth_navigation_bar.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPageWeb extends StatefulWidget {
  const RegisterPageWeb({Key? key}) : super(key: key);

  @override
  State<RegisterPageWeb> createState() => _RegisterPageWebState();
}

class _RegisterPageWebState extends State<RegisterPageWeb> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? name;
  String? password;
  String? email;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Stack(
          children: [
            bgImage(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const AuthNavigationBar(fromLogIn: false),
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
      child: regForm(),
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

  Widget regForm() {
    return ProgressHUD(
      child: Form(key: globalFormKey, child: _registerUI(context)),
      inAsyncCall: isAPICallProcess,
      opacity: 0.3,
      key: UniqueKey(),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          const CreateAccountWeb(),
          const SizedBox(height: 30,),
          formFields(),
          const SizedBox(height: 30,),
          const GButton(isRegisterPage: true),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget formFields() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      "Email".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
      const SizedBox(height: 10),
      FormHelper.inputFieldWidget(
          context,
          "email",
          "example@domain.com",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Email cannot be empty.";
            }
            return null;
          },
              (onSavedVal) {
            email = onSavedVal;
          },
          showPrefixIcon: true,
          prefixIconPaddingLeft: 20.0,
          prefixIconPaddingTop: 20.0,
          prefixIconPaddingBottom: 20.0,
          prefixIcon: const Icon(Icons.mail),
          borderFocusColor: context.cardColor,
          prefixIconColor:context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
          paddingLeft: 0.0,
          paddingRight: 0.0
      ),
      const SizedBox(height: 15,),
      "Password".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
      const SizedBox(height: 10,),
      FormHelper.inputFieldWidget(
        context,
        "password",
        "8+ characters",
            (onValidateVal) {
          if (onValidateVal.isEmpty) {
            return "Password cannot be empty.";
          } else if (onValidateVal.toString().length < 8) {
            return "Password too short";
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
        prefixIcon: const Icon(Icons.lock),
        borderFocusColor: context.cardColor,
        prefixIconColor:context.cardColor,
        borderColor: context.cardColor,
        textColor: context.cardColor,
        hintColor: context.cardColor.withOpacity(0.7),
        borderRadius: 10,
        paddingLeft: 0.0,
        paddingRight: 0.0,
        obscureText: hidePassword,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
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
      ),
      const SizedBox(height: 15,),
      "Confirm Password".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
      const SizedBox(height: 10,),
      FormHelper.inputFieldWidget(
        context,
        "confirm_password",
        "Confirm Password",
            (onValidateVal) {
          if (onValidateVal.isEmpty) {
            return "Confirm Password cannot be empty.";
          } else if(password != confirmPassword){
            return "Password must be same.";
          } else {
            return null;
          }
        },
            (onSavedVal) {
          confirmPassword = onSavedVal;
        },
        showPrefixIcon: true,
        prefixIconPaddingLeft: 20.0,
        prefixIconPaddingTop: 20.0,
        prefixIconPaddingBottom: 20.0,
        prefixIcon: const Icon(Icons.lock),
        borderFocusColor: context.cardColor,
        prefixIconColor:context.cardColor,
        borderColor: context.cardColor,
        textColor: context.cardColor,
        hintColor: context.cardColor.withOpacity(0.7),
        borderRadius: 10,
        paddingLeft: 0.0,
        paddingRight: 0.0,
        obscureText: hidePassword,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
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
      ),
      const SizedBox(height: 15,),
      RichText(
        text: TextSpan(
          style: TextStyle(
            color: context.cardColor.withOpacity(0.5),
            fontSize: 14.0,
          ),
          children: <TextSpan>[
            const TextSpan(text: "By registering, you confirm that you accept our "),
            TextSpan(
              text: 'Terms of Use and Privacy Policy.',
              style: TextStyle(
                color: Colors.yellow.shade800,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, MyRoutes.loginRoute);
                },
            ),
          ],
        ),
      ),
      const SizedBox(height: 25,),
      FormHelper.submitButton(
        "Continue",
            () {
          if (validateAndSave()) {
            Navigator.pushNamed(
                context,
                MyRoutes.registerDetailsRoute,
                arguments: {
                  'email': email, 'password': password
                }
            );
          }
        },
        width: 200,
        height: 60,
        btnColor: context.primaryColor,
        borderColor: Colors.lightBlue.shade800,
        txtColor: MyTheme.white,
        borderRadius: 30,
      ),
      const SizedBox(height: 5,),
    ],
  );

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }
}

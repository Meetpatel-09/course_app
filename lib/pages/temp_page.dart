import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
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
                navigationBar(),
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

  Widget navigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset("assets/images/logo.png", width: 40),
            const SizedBox(width: 10,),
            Config().appName.text.xl3 .semiBold.color(context.primaryColor).make()
          ],
        ),
        Row(
          children: [
            "Already have an account?".text.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
            const SizedBox(width: 15,),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: context.cardColor.withOpacity(0.5),
                  width: 1
                )
              ),
              child: TextButton(
                onPressed: () {

                },
                child: "Sign In".text.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
                style: TextButton.styleFrom(
                  // padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  elevation: 0,
                  shape: const StadiumBorder(),
                ),
              )
            )
          ],
        ),
      ],
    ).pSymmetric(h: 100, v: 20);
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
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/bg4.png'),
              colorFilter: ColorFilter.mode(context.backgroundColor.withOpacity(0.4), BlendMode.modulate,)
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
          createAccount(),
          const SizedBox(height: 30,),
          formFields(),
          const SizedBox(height: 30,),
          googleButton(),
          const SizedBox(height: 35,),
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
        borderFocusColor: context.primaryColor,
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
      const SizedBox(height: 10),
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
        borderFocusColor: context.primaryColor,
        prefixIconColor:context.cardColor,
        borderColor: context.cardColor,
        textColor: context.cardColor,
        hintColor: context.cardColor.withOpacity(0.7),
        borderRadius: 10,
        paddingLeft: 0.0,
        paddingRight: 0.0,
        obscureText: hidePassword,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
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
      const SizedBox(height: 10),
      FormHelper.inputFieldWidget(
        context,
        "confirm_password",
        "Same as Password",
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
        borderFocusColor: context.primaryColor,
        prefixIconColor:context.cardColor,
        borderColor: context.cardColor,
        textColor: context.cardColor,
        hintColor: context.cardColor.withOpacity(0.7),
        borderRadius: 10,
        paddingLeft: 0.0,
        paddingRight: 0.0,
        obscureText: hidePassword,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
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

  Widget createAccount() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Welcome to Course App'.text.bold.size(30).color(context.cardColor).make(),
          'Register Your account'.text.lg.color(context.cardColor.withOpacity(0.7)).make()
        ]
    );
  }

  Widget googleButton() {
    return Row(
      children: [
        "Continue with     ".text.xl.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
        Container(
          width: 35,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: context.cardColor.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(25)
          ),
          child: Image.asset("assets/images/g.png")
        )
      ],
    );
  }
}

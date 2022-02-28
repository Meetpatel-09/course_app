import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class MidSection extends StatefulWidget {
  const MidSection({Key? key}) : super(key: key);

  @override
  _MidSectionState createState() => _MidSectionState();
}

class _MidSectionState extends State<MidSection> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? name;
  String? password;
  String? email;
  String? confirmPassword;

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
        child: Form(key: globalFormKey, child: _registerUI(context)),
        inAsyncCall: isAPICallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          const CreateAccount(),
          const SizedBox(height: 40,),
          formFields(),
          const SizedBox(height: 30,),
          // const FacebookButton(),
          // const SizedBox(height: 50,),
          const GoogleButton(isRegisterPage: true,),
          const SizedBox(height: 15,),
          const LoginLink(),
          const SizedBox(height: 20,),
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
        ),
        const SizedBox(height: 10,),
        FormHelper.inputFieldWidget(
          context,
          "password",
          "Password",
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
          obscureText: hidePassword,
          suffixIcon: IconButton(
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
          obscureText: hidePassword,
          suffixIcon: IconButton(
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
            width: MediaQuery.of(context).size.width - 40,
            btnColor: context.primaryColor,
            borderColor: context.cardColor,
            txtColor: MyTheme.white,
            borderRadius: 10,
          ),
        ).pSymmetric(h: 20),
        const SizedBox(height: 5,),
        // using the velocity_x package have given Horizontal padding of 20 by '.px20()'
        const TermsAndConditions().px20(),
      ],
    ),
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

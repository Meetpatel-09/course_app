import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        iconTheme: IconThemeData(
          color: context.primaryColor
        ),
      ),
      backgroundColor: context.canvasColor,
      body: ProgressHUD(
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
          const CreateAccount(),
          const SizedBox(height: 40,),
          formFields(),
          const SizedBox(height: 30,),
          // const FacebookButton(),
          const SizedBox(height: 50,),
          const GoogleButton(isRegisterPage: true,),
          const SizedBox(height: 15,),
          const LoginLink(),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget formFields() => Column(
    children: [
      FormHelper.inputFieldWidget(
        context,
        const Icon(Icons.mail),
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
        prefixIconColor:context.cardColor,
        borderColor: context.cardColor,
        textColor: context.cardColor,
        hintColor: context.cardColor.withOpacity(0.7),
        borderRadius: 10,
      ),
      const SizedBox(height: 10,),
      FormHelper.inputFieldWidget(
        context,
        const Icon(Icons.lock),
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
        const Icon(Icons.lock),
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
      ),
      const SizedBox(height: 5,),
      const TermsAndConditions().px20(),
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

import 'package:course_app_ui/model/auth_models/register/register_request_model.dart';
import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
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
      body: SingleChildScrollView(
        child: ProgressHUD(
          child: Form(key: globalFormKey, child: _loginUI(context)),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
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
          const CreateAccount(),
          const SizedBox(height: 25,),
          FormHelper.inputFieldWidget(
            context,
            const Icon(Icons.person),
            "name",
            "Name",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Name cannot be empty.";
              }
              return null;
            },
                (onSavedVal) {
              name = onSavedVal;
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
              color: Colors.white.withOpacity(0.7),
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
              color: Colors.white.withOpacity(0.7),
              icon:
              Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          const SizedBox(height: 15,),
          Center(
            child: FormHelper.submitButton(
              "Register",
                  () {
                // if (validateAndSave()) {
                //   setState(() {
                //     isAPICallProcess = true;
                //   });
                //
                //   RegisterRequestModel model = RegisterRequestModel(
                //     name: name!,
                //     email: email!,
                //     password: password!,
                //   );
                //
                //   AuthService.register(model).then((response) {
                //     setState(() {
                //       isAPICallProcess = false;
                //     });
                //     if (response.status == 200) {
                //       FormHelper.showSimpleAlertDialog(
                //         context,
                //         appName,
                //         "Registration Successful. Please Login to the account",
                //         "OK",
                //             () {
                //           Navigator.pushNamedAndRemoveUntil(
                //             context,
                //             '/login',
                //                 (route) => false,
                //           );
                //         },
                //       );
                //     } else {
                //       FormHelper.showSimpleAlertDialog(
                //         context,
                //         appName,
                //         response.msg,
                //         "OK",
                //             () {
                //           Navigator.pop(context);
                //         },
                //       );
                //     }
                //   });
                // }
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
          const SizedBox(height: 30,),
          const FacebookButton(),
          const SizedBox(height: 15,),
          const GoogleButton(),
          const SizedBox(height: 25,),
          const LoginLink(),
          const SizedBox(height: 25,),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    form!.save();
    if (form.validate()) {
      // return true;
      return false;
    } else {
      return false;
    }
  }
}

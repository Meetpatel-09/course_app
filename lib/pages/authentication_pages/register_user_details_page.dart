import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/images/profile_image_widget.dart';
import 'package:course_app_ui/widgets/authentication/links/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterUserDetails extends StatefulWidget {
  const RegisterUserDetails({Key? key, this.email, this.password})
      : super(key: key);
  final String? email;
  final String? password;

  @override
  _RegisterUserDetailsState createState() => _RegisterUserDetailsState();
}

class _RegisterUserDetailsState extends State<RegisterUserDetails> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  int? phoneNo;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        iconTheme: IconThemeData(color: context.primaryColor),
        title: "Complete Profile".text.color(context.primaryColor).make(),
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: ProgressHUD(
          child: Form(key: globalFormKey, child: _takeDetailsUI(context)),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
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
        const ProfileImageWidget(),
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
            return null;
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
            "Register",
                () {
              Navigator.pushNamed(
                context,
                MyRoutes.otpVerificationRoute,
              );
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
      ],
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

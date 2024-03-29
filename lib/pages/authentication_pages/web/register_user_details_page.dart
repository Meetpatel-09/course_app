import 'package:course_app_ui/services/api_service_web.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/auth_navigation_bar.dart';
import 'package:course_app_ui/widgets/web/navigation_bar/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:file_picker/file_picker.dart';

class RegisterUserDetailsWeb extends StatefulWidget {
  final String email;
  final String password;
  final String isGoogle;
  final String? name;
  const RegisterUserDetailsWeb({Key? key, required this.email, required this.password, required this.isGoogle, this.name}) : super(key: key);

  @override
  State<RegisterUserDetailsWeb> createState() => _RegisterUserDetailsWebState();
}

class _RegisterUserDetailsWebState extends State<RegisterUserDetailsWeb> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  List<String> fullName = [];
  String? phoneNo;
  String? address;
  late PlatformFile _file;
  // File? image;
  bool imageSelected = false;

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
            regForm().p(16.0),
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
      height: MediaQuery.of(context).size.height,
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ProgressHUD(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Your Profile'.text.bold.size(30).color(context.cardColor).make(),
              'Complete Your Profile to Continue'.text.lg.color(context.cardColor.withOpacity(0.7)).make()
            ]
          ),
          const SizedBox(height: 30,),
          formFields(),
          const SizedBox(height: 5,),
        ],
      ),
    );
  }

  Widget formFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Stack(
            children: [
              // checking if user use has selected an image from gallery
              imageSelected ? userImage() : buildImage(),
              // positioning the add image icon
              Positioned(
                  bottom: 0,
                  right: 4,
                  child: buildAddImageIcon()
              ),
            ],
          ),
        ),
        // const SizedBox(height: 15,),
        // Align(child: "Profile Picture".text.lg.center.make()),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width / 2.2 : MediaQuery.of(context).size.width / 4.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "First Name".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
                  const SizedBox(height: 10),
                  FormHelper.inputFieldWidget(
                      context,
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
                      showPrefixIcon: true,
                      prefixIconPaddingLeft: 20.0,
                      prefixIconPaddingTop: 20.0,
                      prefixIconPaddingBottom: 20.0,
                      prefixIcon: const Icon(Icons.person),
                      initialValue: firstName,
                      borderFocusColor: context.cardColor,
                      prefixIconColor: context.cardColor,
                      borderColor: context.cardColor,
                      textColor: context.cardColor,
                      hintColor: context.cardColor.withOpacity(0.7),
                      borderRadius: 10,
                      paddingLeft: 0.0,
                      paddingRight: 0.0
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width / 2.2 : MediaQuery.of(context).size.width / 4.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Last Name".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
                  const SizedBox(height: 10),
                  FormHelper.inputFieldWidget(
                      context,
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
                      showPrefixIcon: true,
                      prefixIconPaddingLeft: 20.0,
                      prefixIconPaddingTop: 20.0,
                      prefixIconPaddingBottom: 20.0,
                      prefixIcon: const Icon(Icons.person),
                      initialValue: lastName,
                      borderFocusColor: context.cardColor,
                      prefixIconColor: context.cardColor,
                      borderColor: context.cardColor,
                      textColor: context.cardColor,
                      hintColor: context.cardColor.withOpacity(0.7),
                      borderRadius: 10,
                      paddingLeft: 0.0,
                      paddingRight: 0.0
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        "Phone Number".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
        const SizedBox(height: 10),
        FormHelper.inputFieldWidget(
          context,
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
          showPrefixIcon: true,
          prefixIconPaddingLeft: 20.0,
          prefixIconPaddingTop: 20.0,
          prefixIconPaddingBottom: 20.0,
          prefixIcon: const Icon(Icons.phone_android),
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
          paddingLeft: 0.0,
          paddingRight: 0.0
        ),
        const SizedBox(
          height: 15,
        ),
        "Address".text.xl2.semiBold.color(context.cardColor.withOpacity(0.9)).make(),
        const SizedBox(height: 10),
        FormHelper.inputFieldWidget(
          context,
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
          showPrefixIcon: true,
          prefixIconPaddingLeft: 20.0,
          prefixIconPaddingTop: 20.0,
          prefixIconPaddingBottom: 20.0,
          prefixIcon: const Icon(Icons.home),
          isMultiline: true,
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
          paddingLeft: 0.0,
          paddingRight: 0.0
        ),
        const SizedBox(
          height: 25,
        ),
        FormHelper.submitButton(
          "Register", () async {
          if (validateAndSave()) {
            setState(() {
              isAPICallProcess = true;
            });
            if (widget.isGoogle == "yes") {

              await APIServicesWeb.registerNew(
                firstName + lastName,
                widget.email,
                phoneNo!,
                'password',
                address!,
                'user',
                'Google',
                _file.bytes,
                _file.name,
              ).then((response) async {
                setState(() {
                  isAPICallProcess = false;
                });
                if(response.status == 200) {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.otpVerificationRoute,
                          (route) => false,
                      arguments: {
                        'email': widget.email,
                      }
                  );
                } else {
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
            } else {

              await APIServicesWeb.registerNew(
                firstName + lastName,
                widget.email,
                phoneNo!,
                widget.password,
                address!,
                'user',
                'VPSMCQ',
                _file.bytes,
                _file.name,
              ).then((response) async {
                setState(() {
                  isAPICallProcess = false;
                });
                if(response.status == 200) {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.otpVerificationRoute,
                          (route) => false,
                      arguments: {
                        'email': widget.email,
                      }
                  );
                } else {
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
          width: 200,
          height: 60,
          btnColor: context.primaryColor,
          borderColor: Colors.lightBlue.shade800,
          txtColor: MyTheme.white,
          borderRadius: 30,
        ),
      ],
    );
  }

  // the image which the user selected image form his/her gallery
  Widget userImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: MemoryImage(_file.bytes!),
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          child: InkWell(onTap: () => pickImage(),),
        ),
      ),
    );
  }

  // the default image when the page is first loaded. when the user has not select an image
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

  // the add image icon displayed at the bottom right conner
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

  // code to draw circle
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
      final result = await FilePicker.platform.pickFiles();

      if (result == null) return;

      setState(() {
        _file = result.files.first;
        imageSelected = true;
      });

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
    if (!imageSelected) {
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

  // Storing the user token for future reference
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

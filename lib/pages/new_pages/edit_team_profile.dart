import 'dart:io';

import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/services/google_sign_in_api.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/authentication/links/terms_conditions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:course_app_ui/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

class EditTeamProfile extends StatefulWidget {
  final String email;
  final String password;
  final String isGoogle;
  final String? name;
  const EditTeamProfile({Key? key, required this.email, required this.password, required this.isGoogle, this.name}) : super(key: key);

  @override
  _EditTeamProfileState createState() => _EditTeamProfileState();
}

class _EditTeamProfileState extends State<EditTeamProfile> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  List<String> fullName = [];
  String? phoneNo;
  String? address;
  File? image;

  @override
  Widget build(BuildContext context) {
    // Checking is user has registered with Google
    if (widget.isGoogle == "yes") {
      // Google gives us full name of user e.g. Rohit Sharma so splitting the name
      fullName = widget.name!.split(" ");
      // Setting the user name to variables
      firstName = fullName[0];
      lastName = fullName[1];
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Edit Team'),
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      // used the 'snippet_coder_utils' package for form
      // https://pub.dev/packages/snippet_coder_utils
      // from more details visit the above URL.
      body: ProgressHUD(
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
          const SizedBox(height: 30,),
          formFields(),
          const SizedBox(height: 5,),
          // const TermsAndConditions().px20(),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }

  Widget formFields() {
    return Column(
      children: [
        Stack(
          children: [
            // checking if user use has selected an image from gallery
            image != null ? userImage() : buildImage(),
            // positioning the add image icon
            Positioned(
                bottom: 0,
                right: 4,
                child: buildAddImageIcon()
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Align(child: "Team Profile Picture".text.lg.center.make()),
        const SizedBox(height: 30,),
        FormHelper.inputFieldWidget(
          context,
          "f_name",
          "Team Name",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Team Name cannot be empty.";
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
          prefixIcon: const Icon(Icons.account_box),
          initialValue: firstName,
          borderFocusColor: context.cardColor,
          prefixIconColor: context.cardColor,
          borderColor: context.cardColor,
          textColor: context.cardColor,
          hintColor: context.cardColor.withOpacity(0.7),
          borderRadius: 10,
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // FormHelper.inputFieldWidget(
        //   context,
        //   "address",
        //   "Team Members",
        //       (onValidateVal) {
        //     if (onValidateVal.isEmpty) {
        //       return "Address cannot be empty.";
        //     }
        //     return null;
        //   },
        //       (onSavedVal) {
        //     address = onSavedVal;
        //   },
        //   showPrefixIcon: true,
        //   prefixIconPaddingLeft: 20.0,
        //   prefixIconPaddingTop: 20.0,
        //   prefixIconPaddingBottom: 20.0,
        //   prefixIcon: const Icon(Icons.home),
        //   isMultiline: true,
        //   borderFocusColor: context.cardColor,
        //   prefixIconColor: context.cardColor,
        //   borderColor: context.cardColor,
        //   textColor: context.cardColor,
        //   hintColor: context.cardColor.withOpacity(0.7),
        //   borderRadius: 10,
        // ),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: FormHelper.submitButton(
            "Update Team", () async {
            if (validateAndSave()) {
              setState(() {
                isAPICallProcess = true;
              });
              dio.FormData formData;
              if (widget.isGoogle == "yes") {
                formData = dio.FormData.fromMap({
                  "full_name": firstName + " " + lastName,
                  "email": widget.email,
                  "mobile_no": phoneNo,
                  "address": address,
                  "user_role": 'user',
                  "profile": await dio.MultipartFile.fromFile(image!.path,
                      filename: image!.path.split('/').last),
                });

                AuthService.googleRegister(formData).then((response) async {
                  setState(() {
                    isAPICallProcess = false;
                  });
                  if(response.status == 200) {
                    String token = response.token.toString();
                    setToken(token);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.homeRoute,
                          (route) => false,
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config().appName,
                      response.msg!,
                      "OK",
                          () {
                        Navigator.pop(context);
                        GoogleSignInAPI.logout();
                      },
                    );
                  }
                });
              } else {
                formData = dio.FormData.fromMap({
                  "full_name": firstName + " " + lastName,
                  "email": widget.email,
                  "mobile_no": phoneNo,
                  "password": widget.password,
                  "address": address,
                  "user_role": 'user',
                  "profile": await dio.MultipartFile.fromFile(image!.path,
                      filename: image!.path.split('/').last),
                  "provider": 'VPSMCQ'
                });

                AuthService.register(formData).then((response) async {
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

  // the image which the user selected image form his/her gallery
  Widget userImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: FileImage(image!),
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
          image: const AssetImage("assets/images/team.png"),
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

      // to pick image have use package:image_picker/image_picker.dart package
      // for more details visit https://pub.dev/packages/image_picker
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      // enabling the user to crop image using the package:image_cropper/src/cropper.dart package
      // for more details visit https://pub.dev/packages/image_cropper
      File? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: context.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );

      // compressing the image using package:flutter_image_compress/flutter_image_compress.dart
      // for more details visit https://pub.dev/packages/flutter_image_compress
      final result = await FlutterImageCompress.compressAndGetFile(
        croppedFile!.path,
        image.path,
        quality: 75,
        minWidth: 512,
        minHeight: 512,
      );
      setState(() => this.image = result);

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
    if (image == null) {
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

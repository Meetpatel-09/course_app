import 'dart:io';

import 'package:course_app_ui/services/authentication_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:course_app_ui/utils/config.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isAPICallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String name = "";
  List<String> fullName = [];
  String firstName = "";
  String lastName = "";
  String mobileNo = "";
  String address = "";
  String token = "";
  File? image;
  String userImageString = "";

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    name = arg['name'];
    // Google gives us full name of user e.g. Rohit Sharma so splitting the name
    fullName = name.split(" ");
    // Setting the user name to variables
    firstName = fullName[0];
    lastName = fullName[1];
    mobileNo = arg['mobileNo'];
    address = arg['address'];
    token = arg['token'];
    userImageString = arg['image'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        iconTheme: IconThemeData(color: context.primaryColor),
        title: "Edit Profile".text.color(context.primaryColor).make(),
      ),
      backgroundColor: context.canvasColor,
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
            image != null ? userImage() : userImageString.isNotEmpty ? userImgNetwork() : buildImage(),
            Positioned(
                bottom: 0,
                right: 4,
                child: buildAddImageIcon()
            ),
          ],
        ),
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
          initialValue: firstName,
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
          initialValue: lastName,
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
            mobileNo = onSavedVal;
          },
          initialValue: mobileNo,
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
          initialValue: address,
          isMultiline: true,
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
            "Save", () async {
            if (validateAndSave()) {
              setState(() {
                isAPICallProcess = true;
              });

              dio.FormData formData;

              if (image == null) {
                formData = dio.FormData.fromMap({
                  "full_name": firstName + " " + lastName,
                  "mobile_no": mobileNo,
                  "address": address,
                });
              } else {
                formData = dio.FormData.fromMap({
                  "full_name": firstName + " " + lastName,
                  "mobile_no": mobileNo,
                  "address": address,
                  "profile": await dio.MultipartFile.fromFile(image!.path,
                      filename: image!
                          .path
                          .split('/')
                          .last),
                });
              }
              AuthService.editProfile(formData, token).then((response) async {
                setState(() {
                  isAPICallProcess = false;
                });
                if(response.status == 200) {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.homeRoute,
                          (route) => false,
                  );
                } else {
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config().appName,
                    "Something went wrong",
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
            btnColor: context.primaryColor,
            borderColor: context.cardColor,
            txtColor: MyTheme.white,
            borderRadius: 10,
          ),
        ),
      ],
    );
  }

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

  Widget userImgNetwork() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(Config().mediaAPI + userImageString),
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          child: InkWell(onTap: () => pickImage(),),
        ),
      ),
    );
  }

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
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      File? croppedFile = await ImageCropper.cropImage(
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
      form!.save();
      if (form.validate()) {
        return true;
      } else {
        return false;
      }
    } else {
      form!.save();
      if (form.validate()) {
        return true;
      } else {
        return false;
      }
    }
  }
}

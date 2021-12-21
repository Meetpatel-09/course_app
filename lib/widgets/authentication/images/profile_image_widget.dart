import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {

  File? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          image != null ? userImage() : buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildAddImageIcon()
          ),
        ],
      )
    );
  }

  Widget userImage() {
    print(image);
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

           // Images stored in chase memory temporary
      final imageTemporary = File(image.path);
      // print(imageTemporary);
      setState(() => this.image = imageTemporary);

          // To store image permanently
      // final imagePermanent = await saveImagePermanently(image.path);
      // setState(() => this.image = imagePermanent);
    } catch(e) {
      print("Failed to pick image: $e");
    }
  }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //
  //   return File(imagePath).copy(image.path);
  // }
}

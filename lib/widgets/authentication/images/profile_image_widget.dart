import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildAddImageIcon()
          ),
        ],
      )
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
          child: InkWell(onTap: () {},),
        ),
      ),
    );
  }

  Widget buildAddImageIcon() => buildCircle(
      color: context.canvasColor,
      all: 3,
      child: buildCircle(
        color: context.primaryColor,
        all: 8,
        child: const Icon(
          Icons.add_a_photo,
          size: 20,
          color: Colors.white,
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
}

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: context.primaryColor,
      height: 60,
      child: "Copyright © 2022 All Rights Reserved.".text.color(context.backgroundColor).makeCentered(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({Key? key}) : super(key: key);

  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemBuilder: itemBuilder
    );
  }
}

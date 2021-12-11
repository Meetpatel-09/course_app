import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: 'Create Account'.text.bold.size(35).color(context.primaryColor).make(),
    );
  }
}

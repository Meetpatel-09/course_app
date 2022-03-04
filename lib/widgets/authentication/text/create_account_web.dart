import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateAccountWeb extends StatelessWidget {
  const CreateAccountWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Welcome to Course App'.text.bold.size(30).color(context.cardColor).make(),
          'Register Your account'.text.lg.color(context.cardColor.withOpacity(0.7)).make()
        ]
    );
  }
}

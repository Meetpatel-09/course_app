import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(child: 'Complete Profile'.text.bold.size(30).color(context.primaryColor).make()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: 'Complete your details or continue with social media'.text.center.color(context.cardColor.withOpacity(0.7)).make(),
          )
        ]
    );
  }
}

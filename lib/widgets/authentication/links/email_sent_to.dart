import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EmailSentTo extends StatelessWidget {
  const EmailSentTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: context.cardColor.withOpacity(0.7),
              fontSize: 16.0,
            ),
            children: <TextSpan>[
              const TextSpan(text: "Enter the OTP sent to "),
              TextSpan(
                text: 'example@email.com',
                style: TextStyle(
                  color: context.cardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

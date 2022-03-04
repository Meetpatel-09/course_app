import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class GButton extends StatelessWidget {
  const GButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        "Continue with     ".text.xl.semiBold.color(context.cardColor.withOpacity(0.5)).make(),
        Container(
            width: 35,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: context.cardColor.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(25)
            ),
            child: Image.asset("assets/images/g.png")
        )
      ],
    );
  }
}

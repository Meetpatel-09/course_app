import 'dart:ui';

import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MCQQuestion extends StatefulWidget {
  const MCQQuestion({Key? key}) : super(key: key);

  @override
  _MCQQuestionState createState() => _MCQQuestionState();
}

class _MCQQuestionState extends State<MCQQuestion> {
  List<bool> isSelected = [false, false, false, false];
  List<Widget> toggleButton = [];
  late int selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          header().p0(),
          "-------------------------------------".richText.letterSpacing(2).make().p0(),
          const SizedBox(height: 15,),
          mcqQuestion(),
          // mcqOptions()
        ]
      ),
    );
  }

  Widget header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      questionNumber(),
      examTimer(),
    ],
  );

  Widget questionNumber() => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const SizedBox(width: 15,),
      "1".richText.bold.xl4.make(),
      "/".richText.semiBold.xl4.make().px4(),
      "10".richText.semiBold.xl4.make(),
    ],
  );

  Widget examTimer() {
    return Row(
      children: [
        const Icon(Icons.access_alarm, size: 25,),
        "01".text.xl2.semiBold.make(),
        ":".text.xl2.semiBold.make().px4(),
        "10".text.xl2.semiBold.make(),
        const SizedBox(width: 15,),
      ],
    );
  }

  Widget mcqQuestion() =>
    "A non-null value must be returned since the return type 'Widget' doesn't allow".richText.lg.justify.semiBold.letterSpacing(1).make();

  // Widget mcqOptions() => ToggleButtons(
  //     isSelected: isSelected,
  //     renderBorder: false,
  //     fillColor: context.canvasColor,
  //     splashColor: context.canvasColor,
  //     children: toggleChild(),
  //     onPressed: (int newIndex) {
  //       setState(() {
  //         for (int index = 0; index < 4; index++) {
  //           if (index == newIndex) {
  //             isSelected[index] = true;
  //             selectedOption = newIndex;
  //           } else {
  //             isSelected[index] = false;
  //           }
  //         }
  //       });
  //     },
  // );
  //
  // List<Widget> toggleChild() {
  //   toggleButton = [];
  //   for (int i = 0; i <4; i++) {
  //     toggleButton.add(tButton(i));
  //   }
  //   return toggleButton;
  // }
  //
  // Widget tButton(int i) => Container(
  //     margin: const EdgeInsets.only(right: 10),
  //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: context.primaryColor, width: 2),
  //       borderRadius: const BorderRadius.all(Radius.circular(15)),
  //       color: isSelected[i] ? context.primaryColor : context.canvasColor,
  //     ),
  //     child: Text(
  //      "button text",
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         color: isSelected[i] ? MyTheme.white : context.cardColor,
  //       ),
  //     ));
}

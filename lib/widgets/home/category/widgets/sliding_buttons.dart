import 'package:course_app_ui/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SlidingButtons extends StatefulWidget {
  const SlidingButtons({Key? key}) : super(key: key);

  @override
  _SlidingButtonsState createState() => _SlidingButtonsState();
}

class _SlidingButtonsState extends State<SlidingButtons> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        isSelected: isSelected,
        renderBorder: false,
        color: context.cardColor,
        selectedColor: context.backgroundColor,
        fillColor: context.canvasColor,
        splashColor: context.canvasColor,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: context.primaryColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: isSelected[0] ? context.primaryColor : context.canvasColor,
              ),
              child: const Text('Computer Network', style: TextStyle(fontSize: 15,),)
          ),
          Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.lightBluishColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: isSelected[1] ? context.primaryColor : context.canvasColor,
              ),
              child: const Text('Computer Network')
          ),
          Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.lightBluishColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: isSelected[2] ? context.primaryColor : context.canvasColor,
              ),
              child: const Text('Computer Network')
          ),
        ],
        onPressed: (int newIndex) {
          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true;
              } else {
                isSelected[index] = false;
              }
            }
          });
        },
      ),
    );
  }
}

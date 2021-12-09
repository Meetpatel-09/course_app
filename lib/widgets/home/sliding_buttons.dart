import 'package:course_app_ui/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// class SlidingButtons extends StatelessWidget {
//   const SlidingButtons({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           outlinedButton1(context.cardColor, context.backgroundColor, MyTheme.lightBluishColor),
//           const SizedBox(width: 10,),
//           outlinedButton2(context.cardColor, context.backgroundColor, MyTheme.lightBluishColor),
//           const SizedBox(width: 10,),
//           outlinedButton3(context.cardColor, context.backgroundColor, MyTheme.lightBluishColor),
//           const SizedBox(width: 10,),
//           outlinedButton4(context.cardColor, context.backgroundColor, MyTheme.lightBluishColor),
//           const SizedBox(width: 10,),
//           outlinedButton5(context.cardColor, context.backgroundColor, MyTheme.lightBluishColor),
//           const SizedBox(width: 10,),
//         ],
//       ),
//     );
//   }
//
//   Widget outlinedButton1(Color primaryColor, Color bgColor, Color lightBluishColor) {
//     return OutlinedButton(
//         onPressed: () {},
//         child: Text('Computer Science', style: TextStyle(color: primaryColor),),
//         style: OutlinedButton.styleFrom(
//           // primary: Colors.
//             side: BorderSide(color: lightBluishColor),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             backgroundColor: bgColor
//         )
//     );
//   }
//
//   Widget outlinedButton2(Color primaryColor, Color bgColor, Color lightBluishColor) {
//     return OutlinedButton(
//         onPressed: () {},
//         child: Text('General Awareness', style: TextStyle(color: primaryColor),),
//         style: OutlinedButton.styleFrom(
//           // primary: Colors.
//             side: BorderSide(color: lightBluishColor),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             backgroundColor: bgColor
//         )
//     );
//   }
//
//   Widget outlinedButton3(Color primaryColor, Color bgColor, Color lightBluishColor) {
//     return OutlinedButton(
//         onPressed: () {},
//         child: Text('English', style: TextStyle(color: primaryColor),),
//         style: OutlinedButton.styleFrom(
//           // primary: Colors.
//             side: BorderSide(color: lightBluishColor),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             backgroundColor: bgColor
//         )
//     );
//   }
//
//   Widget outlinedButton4(Color primaryColor, Color bgColor, Color lightBluishColor) {
//     return OutlinedButton(
//         onPressed: () {},
//         child: Text('Aptitude', style: TextStyle(color: primaryColor),),
//         style: OutlinedButton.styleFrom(
//           // primary: Colors.
//             side: BorderSide(color: lightBluishColor),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             backgroundColor: bgColor
//         )
//     );
//   }
//
//   Widget outlinedButton5(Color primaryColor, Color bgColor, Color lightBluishColor) {
//     return OutlinedButton(
//         onPressed: () {},
//         child: Text('Reasoning', style: TextStyle(color: primaryColor),),
//         style: OutlinedButton.styleFrom(
//           // primary: Colors.
//             side: BorderSide(color: lightBluishColor),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             backgroundColor: bgColor
//         )
//     );
//   }
// }

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
        selectedColor: context.primaryColor,
        fillColor: context.canvasColor,
        splashColor: context.canvasColor,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.lightBluishColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: const Text('Computer Network')
          ),
          Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.lightBluishColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: const Text('Computer Network')
          ),
          Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.lightBluishColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
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

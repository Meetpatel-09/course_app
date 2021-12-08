import 'package:course_app_ui/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SlidingButtons extends StatelessWidget {
  const SlidingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          outlinedButton1(context.cardColor),
          const SizedBox(width: 10,),
          outlinedButton2(context.cardColor),
          const SizedBox(width: 10,),
          outlinedButton3(context.cardColor),
          const SizedBox(width: 10,),
          outlinedButton4(context.cardColor),
          const SizedBox(width: 10,),
          outlinedButton5(context.cardColor),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }

  Widget outlinedButton1(Color primaryColor) {
    return OutlinedButton(
        onPressed: () {},
        child: Text('Computer Science', style: TextStyle(color: primaryColor),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: BorderSide(color: MyTheme.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }

  Widget outlinedButton2(Color primaryColor) {
    return OutlinedButton(
        onPressed: () {},
        child: Text('General Awareness', style: TextStyle(color: primaryColor),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: BorderSide(color: MyTheme.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }
  Widget outlinedButton3(Color primaryColor) {
    return OutlinedButton(
        onPressed: () {},
        child: Text('English', style: TextStyle(color: primaryColor),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: BorderSide(color: MyTheme.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }

  Widget outlinedButton4(Color primaryColor) {
    return OutlinedButton(
        onPressed: () {},
        child: Text('Aptitude', style: TextStyle(color: primaryColor),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: BorderSide(color: MyTheme.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }

  Widget outlinedButton5(Color primaryColor) {
    return OutlinedButton(
        onPressed: () {},
        child: Text('Reasoning', style: TextStyle(color: primaryColor),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: BorderSide(color: MyTheme.deepPurple),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }
}

import 'package:flutter/material.dart';

class SlidingButtons extends StatelessWidget {
  const SlidingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          outlinedButton1(),
          const SizedBox(width: 10,),
          outlinedButton2(),
          const SizedBox(width: 10,),
          outlinedButton3(),
          const SizedBox(width: 10,),
          outlinedButton4(),
          const SizedBox(width: 10,),
          outlinedButton5(),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }

  Widget outlinedButton1() {
    return OutlinedButton(
        onPressed: () {},
        child: const Text('Computer Science', style: TextStyle(color: Colors.black),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: const BorderSide(color: Colors.lightBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }

  Widget outlinedButton2() {
    return OutlinedButton(
        onPressed: () {},
        child: const Text('General Awareness', style: TextStyle(color: Colors.black),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: const BorderSide(color: Colors.lightBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }
  Widget outlinedButton3() {
    return OutlinedButton(
        onPressed: () {},
        child: const Text('English', style: TextStyle(color: Colors.black),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: const BorderSide(color: Colors.lightBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }

  Widget outlinedButton4() {
    return OutlinedButton(
        onPressed: () {},
        child: const Text('Aptitude', style: TextStyle(color: Colors.black),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: const BorderSide(color: Colors.lightBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }

  Widget outlinedButton5() {
    return OutlinedButton(
        onPressed: () {},
        child: const Text('Reasoning', style: TextStyle(color: Colors.black),),
        style: OutlinedButton.styleFrom(
          // primary: Colors.
            side: const BorderSide(color: Colors.lightBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        )
    );
  }
}

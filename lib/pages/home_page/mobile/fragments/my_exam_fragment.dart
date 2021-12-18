import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyExamFragment extends StatelessWidget {
  const MyExamFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              Center(heightFactor: 8,child: Text('My Exam', style: TextStyle(fontSize: 55),),)
            ],
          ),
        ),
      ),
    );;
  }
}

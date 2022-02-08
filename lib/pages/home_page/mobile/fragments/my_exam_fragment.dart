import 'package:course_app_ui/widgets/my_exam/my_exam_fragment/category_widget_my_exam.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyExamFragment extends StatelessWidget {
  const MyExamFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          children: const [
            Icon(Icons.receipt_sharp),
            SizedBox(width: 10,),
            Text('My Exam'),
          ],
        ),
        // actions: const [
        //   Align(
        //       alignment: Alignment.centerRight,
        //       child: LogoutIconButton()
        //   )
        // ],
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              CategoryWidgetMyExam(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:course_app_ui/widgets/exam/category_widget_exam.dart';
import 'package:course_app_ui/widgets/home/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamFragment extends StatelessWidget {
  const ExamFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          children: const [
            Icon(Icons.paste),
            SizedBox(width: 10,),
            Text('Exam'),
          ],
        ),
        actions: const [
          Align(
            alignment: Alignment.centerRight,
            child: LogoutIconButton()
          )
        ],
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              CategoryWidgetExam(),
            ],
          ),
        ),
      ),
    );
  }
}

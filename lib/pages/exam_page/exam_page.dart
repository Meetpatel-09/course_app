import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/exam_chooses_page/exam_chooses.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List<Subject>? subjectList = [];
  int index = 0;
  bool _isEmpty = true;
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];

    if (subjectList != null) {
      _isEmpty = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           'Exam'.text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: _isEmpty ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(child: ExamChooses(index: index, subjectList: subjectList,)),
      ),
    );
  }

}

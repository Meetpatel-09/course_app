import 'package:course_app_ui/model/course_model.dart';
import 'package:flutter/material.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({Key? key}) : super(key: key);

  @override
  State<MCQPage> createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  List<Subject>? subjectList = [];
  int index = 0;
  String examTime = "notSet";
  String questionTime = "notSet";

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    index = arg['index'];
    examTime = arg['examTime'];
    questionTime = arg['questionTime'];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

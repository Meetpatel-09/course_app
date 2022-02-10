import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/mcq_widget.dart';
import 'package:flutter/material.dart';

class MyExamMCQPage extends StatefulWidget {
  const MyExamMCQPage({Key? key}) : super(key: key);

  @override
  _MyExamMCQPageState createState() => _MyExamMCQPageState();
}

class _MyExamMCQPageState extends State<MyExamMCQPage> {
  late List<Result> myExamResultList;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    myExamResultList = arg['myExamResultList'];

    return MCQWidget(
      controller: controller,
      myExamResultList: myExamResultList,
      onChangedPage: (page) {
        if (page == myExamResultList.length - 1) {
          setState(() {
            // btnText = "last page";
          });
        }
      },
    );
  }
}
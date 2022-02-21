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
  late MyExamResultModel myExamResult;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    // initializing the page controller
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    // disposing the page controller
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    myExamResult = arg['myExamResult'];
    myExamResultList = myExamResult.result!;

    return MCQWidget(
      controller: controller,
      myExamResultList: myExamResultList,
      myExamResult: myExamResult,
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

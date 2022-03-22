import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/widgets/my_exam/mcq_page/mcq_widget.dart';
import 'package:flutter/material.dart';

class MyExamMCQPageMobile extends StatefulWidget {
  final List<Result> myExamResultList;
  final MyExamResultModel myExamResult;
  const MyExamMCQPageMobile({Key? key, required this.myExamResultList, required this.myExamResult}) : super(key: key);

  @override
  _MyExamMCQPageMobileState createState() => _MyExamMCQPageMobileState();
}

class _MyExamMCQPageMobileState extends State<MyExamMCQPageMobile> {
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

    return MCQWidget(
      controller: controller,
      myExamResultList: widget.myExamResultList,
      myExamResult: widget.myExamResult,
      onChangedPage: (page) {
        if (page == widget.myExamResultList.length - 1) {
          setState(() {
            // btnText = "last page";
          });
        }
      },
    );
  }
}
